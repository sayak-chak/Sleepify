import 'package:flutter/material.dart';

abstract class PlayPauseButtonState {}

class LoadingState extends PlayPauseButtonState {}

class UpdatePlayPauseButton extends PlayPauseButtonState {
  final IconData newButton;
  UpdatePlayPauseButton({@required this.newButton});
}
