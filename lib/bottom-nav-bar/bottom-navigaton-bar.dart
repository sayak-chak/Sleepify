import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sleepify/bottom-nav-bar/bloc/botton_nav_bloc.dart';
import 'package:Sleepify/constants.dart';
import 'package:Sleepify/bottom-nav-bar/bloc/bottom_nav_event.dart';
import 'package:Sleepify/main.dart';

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
      selectedIconTheme: IconThemeData(
        // color: Colors.blue,
        // opacity: 100,
        size: 35,
      ),
      currentIndex: activeScreenIndex,
      backgroundColor: Color.fromRGBO(20, 10, 40, 1),
      items: const <BottomNavigationBarItem>[
        // BottomNavigationBarItem(
        //   activeIcon: Icon(
        //     FontAwesomeIcons.home,
        //     color: Colors.red,
        //   ),
        //   icon: Icon(
        //     FontAwesomeIcons.home,
        //     color: Colors.white,
        //   ),
        //   label: '',
        // ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            FontAwesomeIcons.music,
            color: Colors.blue,
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
            color: Colors.blue,
          ),
          icon: Icon(
            FontAwesomeIcons.clock,
            color: Colors.white,
          ),
          label: '',
        ),
      ],
      selectedItemColor: Colors.white,
      onTap: (selectedPageIndex) {
        setState(() {
          activeScreenIndex = selectedPageIndex;
        });
        BlocProvider.of<BottomNavBarBloc>(context)
            .add(ChangeAppBody(updatedAppBodyIndex: selectedPageIndex));
      },
    );
  }
}
