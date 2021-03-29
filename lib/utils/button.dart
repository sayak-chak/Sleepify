import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color buttonColor;
  final String buttonTitle;
  final Function onPressed;
  final double fontSize;
  Button(
      {@required this.buttonTitle,
      @required this.onPressed,
      @required this.buttonColor,
      @required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: TextStyle(color: Colors.black, fontSize: fontSize),
      ),
    );
  }
}
