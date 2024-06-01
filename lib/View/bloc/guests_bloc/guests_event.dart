part of 'guests_bloc.dart';

sealed class GuestsEvent extends Equatable {
  const GuestsEvent();

  @override
  List<Object> get props => [];
}

class LoadGuests extends GuestsEvent {}

class AddGuest extends GuestsEvent {
  final Guest guest;

  const AddGuest(this.guest);
}

class DeleteGuest extends GuestsEvent {
  final String guestId;

  const DeleteGuest(this.guestId);
}

class UpdateGuest extends GuestsEvent {
  final Guest updatedGuest;

  const UpdateGuest(this.updatedGuest);

  @override
  List<Object> get props => [updatedGuest];
}
