part of 'guests_bloc.dart';

sealed class GuestsState extends Equatable {
  const GuestsState();

  @override
  List<Object> get props => [];
}

class GuestLoading extends GuestsState {}

class GuestLoaded extends GuestsState {
  final List<Guest> guests;

  const GuestLoaded(this.guests);
}

class GuestError extends GuestsState {
  final String message;

  const GuestError(this.message);
}
