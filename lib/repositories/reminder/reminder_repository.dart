import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sleep_diary_mobile/models/reminder_model.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderRepository {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeReminder() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<TimeOfDay> getReminderTime() async {
    try {
      final reminderDoc = await FirebaseFirestore.instance
          .collection('reminders')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (reminderDoc.docs.isNotEmpty) {
        return ReminderModel.fromJson(reminderDoc.docs.first.data()).time!;
      } else {
        await FirebaseFirestore.instance
            .collection('reminders')
            .add(ReminderModel.empty().toJson());
        return ReminderModel.empty().time!;
      }
    } catch (e) {
      return ReminderModel.empty().time!;
    }
  }

  Future<void> updateReminderTime(TimeOfDay time) async {
    final reminderData = await FirebaseFirestore.instance
        .collection('reminders')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    await reminderData.docs.first.reference.update({
      'time': {'hour': time.hour, 'minute': time.minute}
    });
  }

  Future<bool> getReminderIsActive() async {
    try {
      final reminderDoc = await FirebaseFirestore.instance
          .collection('reminders')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (reminderDoc.docs.isNotEmpty) {
        return ReminderModel.fromJson(reminderDoc.docs.first.data())
            .isActiveReminder!;
      } else {
        return ReminderModel.empty().isActiveReminder!;
      }
    } catch (e) {
      return ReminderModel.empty().isActiveReminder!;
    }
  }

  Future<void> updateReminderIsActive(bool isActiveReminder) async {
    final reminderData = await FirebaseFirestore.instance
        .collection('reminders')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    await reminderData.docs.first.reference
        .update({'isActiveReminder': isActiveReminder});
  }

  Future<void> onReminderNotification(TimeOfDay time) async {

    offReminderNotification();

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'SleepDiary', 'Jangan Lupa Tidur',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/launcher_icon');

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Ceritanya Cuman Reminder Bang, Tapi Kurang 5 Menit',
        'Jangan Lupa untuk Membersihkan Badan dan Kasur Supaya Tidur Lebih Nyaman',
        tz.TZDateTime(
            tz.local,
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            (time.minute < 5) ? time.hour - 1 : time.hour,
            (time.minute < 5) ? time.minute + 55 : time.minute - 5),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'item x');

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Ceritanya Cuman Reminder Bang',
        'Bang Tidur Bang',
        tz.TZDateTime(tz.local, DateTime.now().year, DateTime.now().month,
            DateTime.now().day, time.hour, time.minute),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'item x');
  }

  Future<void> offReminderNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
