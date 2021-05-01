import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_bloc.dart';
import 'package:Sleepify/sleep-music/bloc/sleep-music-icon-bloc/sleep_music_icon_event.dart';

class SleepMusicListPickers extends StatefulWidget {
  // final String selectedSleepMusicType;
  // SleepMusicListPickers({@required this.selectedSleepMusicType});
  @override
  State<StatefulWidget> createState() =>
      SleepMusicListPickersState(selectedSleepMusicType: "Animals And Birds");
}

class SleepMusicListPickersState extends State<SleepMusicListPickers> {
  String selectedSleepMusicType;
  SleepMusicListPickersState({@required this.selectedSleepMusicType});
  void updateSelectedSleepMusicType(String sleepMusicType) {
    setState(() {
      selectedSleepMusicType = sleepMusicType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        // clipBehavior: Clip.antiAlias,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SleepMusicListPicker(
              typeOfMusicList: "Animals & Birds",
              updateSelectedSleepMusicType: updateSelectedSleepMusicType,
              isSelected: selectedSleepMusicType == "Animals & Birds",
            ),
            SleepMusicListPicker(
              typeOfMusicList: "Nature",
              updateSelectedSleepMusicType: updateSelectedSleepMusicType,
              isSelected: selectedSleepMusicType == "Nature",
            ),
            SleepMusicListPicker(
              typeOfMusicList: "ASMR & Focus",
              updateSelectedSleepMusicType: updateSelectedSleepMusicType,
              isSelected: selectedSleepMusicType == "ASMR & Focus",
            ),
          ],
        ),
      ),
    );
  }
}

class SleepMusicListPicker extends StatelessWidget {
  final bool isSelected;
  final String typeOfMusicList;
  final Function updateSelectedSleepMusicType;
  SleepMusicListPicker({
    @required this.typeOfMusicList,
    @required this.updateSelectedSleepMusicType,
    @required this.isSelected,
  });
  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.only(right: 2, left: 2),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          updateSelectedSleepMusicType(typeOfMusicList);
          BlocProvider.of<SleepMusicIconBloc>(context).add(
            UpdateSleepMusicTypeList(
              sleepMusicListType: typeOfMusicList,
            ),
          );
        },
        child: Text(
          typeOfMusicList,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
