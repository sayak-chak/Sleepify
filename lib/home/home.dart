import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home-menu-option.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: ListView(
        children: [
          HomeMenuOption(
            option: AppLocalizations.of(context).powerNap,
            iconType: FontAwesomeIcons.bed,
          ),
          HomeMenuOption(
            option: AppLocalizations.of(context).asmr,
            iconType: FontAwesomeIcons.music,
          ),
          HomeMenuOption(
            option: AppLocalizations.of(context).alarm,
            iconType: FontAwesomeIcons.clock,
          ),
        ],
      ),
    );
  }
}

// FontAwesomeIcons.bed,
// FontAwesomeIcons.music
