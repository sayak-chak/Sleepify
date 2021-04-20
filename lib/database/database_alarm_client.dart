/// ClientModel.dart
import 'dart:convert';

import 'package:flutter/material.dart';

AlarmClient clientFromJson(String str) {
  final jsonData = json.decode(str);
  return AlarmClient.fromMap(jsonData);
}

String clientToJson(AlarmClient data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class AlarmClient {
  int minutes_id;
  bool sunday;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool saturday;

  AlarmClient(
      {@required this.minutes_id,
      @required this.sunday,
      @required this.monday,
      @required this.tuesday,
      @required this.wednesday,
      @required this.thursday,
      @required this.friday,
      @required this.saturday});

  factory AlarmClient.fromMap(Map<String, dynamic> json) => new AlarmClient(
        minutes_id: json["minutes_id"] as int,
        sunday: json["sunday"] == 1,
        monday: json["monday"] == 1,
        tuesday: json["tuesday"] == 1,
        wednesday: json["wednesday"] == 1,
        thursday: json["thursday"] == 1,
        friday: json["friday"] == 1,
        saturday: json["saturday"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "minutes_id": minutes_id,
        "sunday": sunday ? 1 : 0,
        "monday": monday ? 1 : 0,
        "tuesday": tuesday ? 1 : 0,
        "wednesday": wednesday ? 1 : 0,
        "thursday": thursday ? 1 : 0,
        "friday": friday ? 1 : 0,
        "saturday": saturday ? 1 : 0
      };
}
