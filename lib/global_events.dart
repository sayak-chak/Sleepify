import 'package:flutter/material.dart';

abstract class GlobalEvent {}

class AddNewAlarm extends GlobalEvent {}

class ChangeAppBody extends GlobalEvent {
  int updatedAppBodyIndex;
  ChangeAppBody({@required this.updatedAppBodyIndex});  
}
