import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forever_bond/Model/guest.dart';
import 'package:forever_bond/ViewModel/guest_vm.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  final GuestVM guestViewModel;

  GuestsBloc({required this.guestViewModel}) : super(GuestLoading()) {
    on<LoadGuests>(_onLoadGuests);
    on<AddGuest>(_onAddGuest);
    on<UpdateGuest>(_onUpdateGuest);
    on<DeleteGuest>(_onDeleteGuest);
  }

  Future<void> _onLoadGuests(
      LoadGuests event, Emitter<GuestsState> emit) async {
    emit(GuestLoading());
    try {
      final guests = await guestViewModel.getGuests().first;
      emit(GuestLoaded(guests));
    } catch (e) {
      emit(GuestError('Failed to load guests: $e'));
    }
  }

  Future<void> _onAddGuest(AddGuest event, Emitter<GuestsState> emit) async {
    emit(GuestLoading());
    try {
      await guestViewModel.addGuest(event.guest);
      final guests = await guestViewModel.getGuests().first;
      emit(GuestLoaded(guests));
    } catch (e) {
      emit(GuestError('Failed to add guest: $e'));
    }
  }

  Future<void> _onUpdateGuest(
      UpdateGuest event, Emitter<GuestsState> emit) async {
    emit(GuestLoading());
    try {
      await guestViewModel.updateGuest(event
          .updatedGuest); // Metoda de actualizare a invitatului în ViewModel
      final guests = await guestViewModel.getGuests().first;
      emit(GuestLoaded(guests));
    } catch (e) {
      emit(GuestError('Failed to update guest: $e'));
    }
  }

  Future<void> _onDeleteGuest(
      DeleteGuest event, Emitter<GuestsState> emit) async {
    emit(GuestLoading());
    try {
      await guestViewModel.deleteGuest(event.guestId);
      final guests = await guestViewModel.getGuests().first;
      emit(GuestLoaded(guests));
    } catch (e) {
      emit(GuestError('Failed to delete guest: $e'));
    }
  }
}
