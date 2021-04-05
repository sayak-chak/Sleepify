import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlarmTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 50, bottom: 50, left: 40, right: 40),
      // width: 300,
      child: Row(children: [
        Flexible(
          child: Column(children: [
            Container(
              // width: 150,
              height: 200,
              child: CupertinoPicker(
                looping: true,
                backgroundColor: Colors.black54,
                magnification: 1.15,
                onSelectedItemChanged: (val) {},
                itemExtent: 50,
                children: [...Constants.listOfHours],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                onPressed: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).cancel,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        Flexible(
          child: Column(children: [
            Container(
              // width: 140,
              color: Colors.black54,
              alignment: Alignment.center,
              // width: 60,
              height: 200,
              child: Text(
                ":",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: TextButton(
                onPressed: null,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
        Flexible(
          child: Column(children: [
            Container(
              // width: 150,
              height: 200,
              child: CupertinoPicker(
                looping: true,
                backgroundColor: Colors.black54,
                magnification: 1.15,
                onSelectedItemChanged: (val) {},
                itemExtent: 50,
                children: [...Constants.listOfHours],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: TextButton(
                onPressed: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).save,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
