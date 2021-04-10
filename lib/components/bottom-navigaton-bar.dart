import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/constants.dart';
import 'package:sleep/global_events.dart';
import 'package:sleep/main.dart';

class SleepAppBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SleepAppBottomNavigationBarState();
}

class SleepAppBottomNavigationBarState
    extends State<SleepAppBottomNavigationBar> {
  int activeScreenIndex = Constants.HOME_PAGE_INDEX;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeScreenIndex,
      backgroundColor: Color.fromRGBO(20, 10, 40, 1),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Icon(
            FontAwesomeIcons.home,
            color: Colors.red,
          ),
          icon: Icon(
            FontAwesomeIcons.home,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            FontAwesomeIcons.music,
            color: Colors.red,
          ),
          icon: Icon(
            FontAwesomeIcons.music,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            FontAwesomeIcons.clock,
            color: Colors.red,
          ),
          icon: Icon(
            FontAwesomeIcons.clock,
            color: Colors.white,
          ),
          label: '',
        ),
      ],
      selectedItemColor: Colors.amber[800],
      onTap: (selectedPageIndex) {
        setState(() {
          activeScreenIndex = selectedPageIndex;
        });
        GLOBAL_BLOC.appGlobalEventSink
            .add(ChangeAppBody(updatedAppBodyIndex: selectedPageIndex));
      },
    );
  }
}
