// ! need to be implement

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/home/cubit/sorted_button_state.dart';
import 'package:meta/meta.dart';

class SortedButtonCubit extends Cubit<SortedButtonState> {
  SortedButtonCubit() : super(SortedButtonInitial());
  late Box<ContactModel> contactBox;
  void sortList(List<ContactModel> keyValue) {
    keyValue.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });
  }
}
