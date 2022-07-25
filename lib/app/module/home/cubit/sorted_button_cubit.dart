// ! need to be implement

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud_with_bloc/app/data/Model/contact_details.dart';
import 'package:hive_crud_with_bloc/app/module/home/cubit/sorted_button_state.dart';
import 'package:meta/meta.dart';

class SortedButtonCubit extends Cubit<SortedButtonState> {
  SortedButtonCubit() : super(SortedButtonInitial());
  late Box<ContactModel> contactBox;

  void sortbyDateTime(List<ContactModel> keyValue) {
    emit(LoadingState());
    keyValue.sort((a, b) {
      return a.dateTime
          .toString()
          .toLowerCase()
          .compareTo(b.dateTime.toString().toLowerCase());
    });

    emit(SortedState(keyValue));
  }

  void sortedbyName(List<ContactModel> keyValue) {
    emit(LoadingState());
    keyValue.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });

    emit(SortedState(keyValue));
  }

  void sortedbyPhone(List<ContactModel> keyValue) {
    emit(LoadingState());
    keyValue.sort((a, b) {
      return a.phone
          .toString()
          .toLowerCase()
          .compareTo(b.phone.toString().toLowerCase());
    });

    emit(SortedState(keyValue));
  }

  void sortedbyEmail(List<ContactModel> keyValue) {
    emit(LoadingState());
    keyValue.sort((a, b) {
      return a.email
          .toString()
          .toLowerCase()
          .compareTo(b.email.toString().toLowerCase());
    });

    emit(SortedState(keyValue));
  }

  void sortBy(value, BuildContext context, List<ContactModel> keyValue) {
    if (value == 0) {
      BlocProvider.of<SortedButtonCubit>(context).sortedbyName(keyValue);
    }
    if (value == 1) {
      BlocProvider.of<SortedButtonCubit>(context).sortbyDateTime(keyValue);
    }
    if (value == 2) {
      BlocProvider.of<SortedButtonCubit>(context).sortedbyEmail(keyValue);
    }
    if (value == 3) {
      BlocProvider.of<SortedButtonCubit>(context).sortedbyPhone(keyValue);
    }
  }
}
