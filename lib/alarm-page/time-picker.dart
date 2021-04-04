import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/constants.dart';


class TimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sleep;
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.black54,
      //   borderRadius: BorderRadius.all(Radius.circular(100)),
      // ),
      color: Colors.black54,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 100, bottom: 100),
      height: 250,
      width: (MediaQuery.of(context).size.width / 3) * 2,
      child: Row(children: [
        Container(
          child: Flexible(
            child: Column(children: [
              Container(
                height: 200,
                child: CupertinoPicker(
                  looping: true,
                  // backgroundColor: Colors.black54,
                  onSelectedItemChanged: (val) {},
                  itemExtent: 40,
                  children: [...Constants.listOfHours],
                ),
              ),
              Container(
                  // alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 6,
                  height: 50,
                  color: Colors.black54,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel", //TODO: refactor
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        Flexible(
          child: Container(
            // color: Colors.black54,
            alignment: Alignment.center,
            // width: 60,
            height: 200,
            child: Text(
              " : ",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        Container(
          child: Flexible(
            child: Column(children: [
              Container(
                height: 200,
                child: CupertinoPicker(
                  looping: true,
                  backgroundColor: Colors.black54,
                  onSelectedItemChanged: (val) {},
                  itemExtent: 40,
                  children: [...Constants.listOfHours],
                ),
              ),
              Container(
                  // alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 6,
                  height: 50,
                  // color: Colors.transparent,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
      ]),
    );
  }
}
