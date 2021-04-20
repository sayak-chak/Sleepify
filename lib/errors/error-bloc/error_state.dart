import 'package:flutter/material.dart';

abstract class ErrorState {}

class DisplayError extends ErrorState {
  final String errorMessage;
  DisplayError({@required this.errorMessage});
}

class NoError extends ErrorState {}
