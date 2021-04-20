import 'package:flutter/material.dart';

abstract class ErrorEvent {}

class NewError extends ErrorEvent {
  final String errorMessage;
  NewError({@required this.errorMessage});
}

class RemoveError extends ErrorEvent {} //TODO:maybe refactor
