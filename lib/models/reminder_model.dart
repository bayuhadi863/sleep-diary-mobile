import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReminderModel {
  
  TimeOfDay? time;
  bool? isActiveReminder;

  ReminderModel({
    this.time,
    this.isActiveReminder
  });

  static ReminderModel empty() => ReminderModel(
    time: const TimeOfDay(hour: 0, minute: 0),
    isActiveReminder: false,
  );

  Map<String, dynamic> toJson() {
    return {
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'time': {
        'hour': time!.hour,
        'minute': time!.minute
      },
      'isActiveReminder': isActiveReminder
    };
  }

  factory ReminderModel.fromJson(json) {
    return ReminderModel(
      time: TimeOfDay(hour: json['time']['hour'], minute: json['time']['minute']),
      isActiveReminder: json['isActiveReminder']
    );
  }

}