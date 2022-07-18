part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactState {}

class AddContactInitial extends AddContactState {}

class AddContactError extends AddContactState {
  final String errorMsg;
  AddContactError(this.errorMsg);
}

class AddContactValid extends AddContactState {}

class AddContactLoading extends AddContactState {}
