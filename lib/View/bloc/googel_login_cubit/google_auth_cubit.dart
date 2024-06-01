import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitialState());

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  void login() async {
    emit(GoogleAuthLoadingState());
    try {
      // Select google account
      final userAccount = await _googleSignIn.signIn();

      // User dismissed the account dialog
      if (userAccount == null) {
        emit(GoogleAuthDismissedState());
        return;
      }

      // Get authentication object from account
      final GoogleSignInAuthentication googleAuth =
          await userAccount.authentication;

      // Create AuthCredentials from auth object
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login to firebase using the credentials
      // ignore: unused_local_variable
      final userCredential = await _auth.signInWithCredential(credential);

      // Emit navigation event on successful sign-in
      emit(GoogleAuthNavigateToHome());
    } catch (e) {
      emit(GoogleAuthFailedState(e.toString()));
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      emit(GoogleAuthInitialState());
      emit(
          GoogleAuthNavigateToLogin()); // Emit navigation event after signing out
    } catch (e) {
      emit(GoogleAuthFailedState(e.toString()));
    }
  }
}
