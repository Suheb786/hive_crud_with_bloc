import 'package:flutter/material.dart';
import '../../../data/Model/contact_details.dart';

@immutable
abstract class SortedButtonState {}

class SortedButtonInitial extends SortedButtonState {}

class SortedState extends SortedButtonState {
  final List<ContactModel> sortedContectList;

  SortedState(this.sortedContectList);
}

class LoadingState extends SortedButtonState {}
