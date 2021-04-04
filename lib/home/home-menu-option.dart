import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleep/constants.dart';

class HomeMenuOption extends StatelessWidget {
  final String option;
  final IconData iconType;

  HomeMenuOption({this.option, this.iconType});
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        color: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: FaIcon(
            iconType,
            size: 60,
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              this.option,
              style: GoogleFonts.robotoSlab(fontSize: 25),
            ),
          ),
          trailing: FaIcon(
            iconType,
            size: 60,
          ),
          onTap: () => {Navigator.pushNamed(context, '/powerNap')},
        ));
  }
}
