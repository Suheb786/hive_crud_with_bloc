import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:meta/meta.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileNOCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  late final key = nameCtrl.text;
  late final value = mobileNOCtrl.text;

  late Box<ContactModel> contactBox;

  AddContactBloc() : super(AddContactInitial()) {
    on<TextChangedEvent>((event, emit) {
      if (event.nameValue.length < 3) {
        emit(AddContactError("please enter Valid Name"));
      } else if (event.mobileNoValue.length <= 9) {
        emit(AddContactError("Please Enter a Mobile Number"));
      } else if (!emailRex.hasMatch(event.emailValue)) {
        emit(AddContactError("Please Enter a valid email"));
      } else {
        emit(AddContactValid());
      }
    });
  }

  void check_and_save() {
    ContactModel modelvalue = ContactModel(key, int.parse(value));
    contactBox.add(modelvalue);
  }

  RegExp emailRex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}
