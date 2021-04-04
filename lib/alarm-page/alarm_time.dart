import 'package:flutter/material.dart';
import 'package:sleep/constants.dart';

class AlarmTime extends StatelessWidget {
  final String hh, mm;
  AlarmTime({@required this.hh, @required this.mm});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.DEFAULT_BUTTON_COLOR_NON_SOLID,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(hh + " : " + mm),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
