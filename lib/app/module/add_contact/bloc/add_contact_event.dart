part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactEvent {}

class TextChangedEvent extends AddContactEvent {
  final String nameValue;
  final String mobileNoValue;
  final String emailValue;

  TextChangedEvent(
    this.nameValue,
    this.mobileNoValue,
    this.emailValue,
  );
}

class SaveEvent {
  final String email;
  final String password;
  final String mobileNo;

  SaveEvent(
    this.email,
    this.password,
    this.mobileNo,
  );
}
