import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleep/constants.dart';

class SleepAppBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SleepAppBottomNavigationBarState();
  }
}

class SleepAppBottomNavigationBarState
    extends State<SleepAppBottomNavigationBar> {
  int currentPageIndex = 0; //TODO - refactor maybe
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(20, 10, 40, 1),
      items: const <BottomNavigationBarItem>[
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
      ],
      currentIndex: currentPageIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (selectedPageIndex) {
        setState(() {
          currentPageIndex = selectedPageIndex;
          Navigator.pushNamed(context,
              Constants.ROUTE_CORRESPONDING_TO_INDEX[selectedPageIndex]);
        });
      },
    );
  }
}
