import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc() : super(AddContactInitial()) {
    on<TextChangedEvent>((event, emit) {
      if (event.nameValue.length < 3) {
        emit(AddContactError("please enter Valid Name"));
      } else if (event.mobileNoValue.length <= 9) {
        emit(AddContactError("Please Enter a Password"));
      } else if (!emailRex.hasMatch(event.emailValue)) {
        emit(AddContactError("Please Enter a valid email"));
      } else {
        emit(AddContactValid());
      }
    });
  }

  RegExp emailRex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}
