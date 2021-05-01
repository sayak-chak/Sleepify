import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  ErrorDialog({@required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.white,
    //   child: Center(child: Text(errorMessage)),
    // );
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        FontAwesomeIcons.exclamation,
        color: Colors.greenAccent,
      ),
      title: "Hey!",
      message: errorMessage,
      duration: Duration(seconds: 3),
    );
  }
}
