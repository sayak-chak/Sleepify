import 'package:flutter/material.dart';

abstract class BottomNavEvent {}

class ChangeAppBody extends BottomNavEvent {
  int updatedAppBodyIndex;
  ChangeAppBody({@required this.updatedAppBodyIndex});
}
