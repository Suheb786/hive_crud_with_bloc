import 'package:flutter/material.dart';

@immutable
abstract class SortedButtonState {}

class SortedButtonInitial extends SortedButtonState {}

class SortedState extends SortedButtonState {}

class LoadingState extends SortedButtonState {}
