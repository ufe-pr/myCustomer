import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRemindersService {
  var flutterLocalNotificationsPlugin;

  NotificationRemindersService() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  // initialise the plugin.
  void initNotifications() {
    // Sets icon to be displayed with notification (android).
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // Intialization requires two arguments, for IOS and Android. IOS requires more , but that hasn't been set yet.
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  dynamic pendingNotificationRequests() async =>
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

// Function to schedule a reminder at a specific time daily
  void sendNotificationDaily(
      {int id, String title, String body, int hour, int minute}) async {
    var time = new Time(hour, minute, 0);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics(id));

    print(
        'Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  }

// Function to schedule reminder on a specific date but just once
  void sendNotificationOnce(
      int id, String title, String body, DateTime time) async {
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, time, getPlatformChannelSpecfics(id));

    print(
        'Notification Succesfully Scheduled for ${time.toString()} with id of $id');
  }

// This as the function name states, sets given properties to the notification.
  getPlatformChannelSpecfics(int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

// IOS
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

// To navigate to a certain screen on click of notification for devices notification panel
  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // await Navigator.pushNamed(context,
    // screen name goes here
    // );
  }

// Function to remove reminder, in the case where well, the data was deleted. So user won't receive notification still.
  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notfication with id: $notificationId been removed successfully');
  }
}
