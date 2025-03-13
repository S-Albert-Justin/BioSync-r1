import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'heartrate2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();
  runApp(MyApp());
}

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.request();
  if (status.isDenied) {
    // You can show a dialog here if permission is denied
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeStatsScreen(),
    );
  }
}
