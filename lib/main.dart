import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sleep/power-nap/power-nap.dart';
import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
      '/powerNap': (BuildContext context) => PowerNap(),
    },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      title: 'Flutter Demo',
      home: Material(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/moonlight.jpeg"), fit: BoxFit.fill),
            ),
            child: Home()),
      ),
    );
  }
}

//imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
