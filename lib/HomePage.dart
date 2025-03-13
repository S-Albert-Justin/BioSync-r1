import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter/material.dart';

const int baseRootColour = 0xff007bff;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text(
          "Medical Profile",
          style: TextStyle(color: Color(baseRootColour)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.medical_information_outlined,
                color: Colors.black54, size: 30),
            onPressed: () {
              _navigateToPage(context, MedicinePage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_2, color: Colors.black),
            onPressed: () {
              _navigateToPage(context, QrPage());
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xffE8F0F9),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile Card
            Neumorphic(
              style: NeumorphicStyle(
                depth: 5,
                intensity: 0.6,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile Image
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: const Color(baseRootColour),
                                width: 3,
                              )),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/Carlotta.png",
                              width: 120,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Carlotta",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(baseRootColour)),
                        ),
                        const SizedBox(height: 4),
                        const Text("Age: 57 | Blood Type: O+",
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        const Divider(),
                        _profileDetailItem(
                            Icons.phone, "Emergency Contact: +1 123 456 7890"),
                        _profileDetailItem(Icons.local_hospital,
                            "Medical Condition: Diabetic"),
                        _profileDetailItem(
                            Icons.medical_services, "Allergies: Penicillin"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Neumorphic(
              style: NeumorphicStyle(
                depth: 5,
                intensity: 0.6,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                color: Colors.white,
              ),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/Smart_Band.png"),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart Aid Connected",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(baseRootColour)),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.bluetooth_connected,
                                color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text("Syncing data...",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                height: 100,
                margin: const EdgeInsets.all(23),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 22),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

void _navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final List<Map<String, dynamic>> medicines = [
    {
      'time': 'Morning',
      'medications': [
        {'name': 'Metformin', 'dose': '500mg'},
        {'name': 'Glipizide', 'dose': '10mg'},
        {'name': 'Acarbose', 'dose': '50mg'},
        {'name': 'Vildagliptin', 'dose': '50mg'}
      ],
      'taken': false,
      'highlighted': false,
    },
    {
      'time': 'Evening',
      'medications': [
        {'name': 'Sitagliptin', 'dose': '100mg'},
        {'name': 'Repaglinide', 'dose': '1mg'},
        {'name': 'Dapagliflozin', 'dose': '10mg'},
        {'name': 'Empagliflozin', 'dose': '25mg'}
      ],
      'taken': false,
      'highlighted': false,
    },
    {
      'time': 'Night',
      'medications': [
        {'name': 'Pioglitazone', 'dose': '30mg'},
        {'name': 'Canagliflozin', 'dose': '300mg'},
        {'name': 'Linagliptin', 'dose': '5mg'},
        {'name': 'Rosiglitazone', 'dose': '4mg'}
      ],
      'taken': false,
      'highlighted': false,
    }
  ];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeNotifications();
  }

  void _requestPermissions() async {
    await Permission.notification.request();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'medicine_channel',
      'Medicine Reminders',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Medicine Reminder',
      message,
      platformChannelSpecifics,
    );
  }

  Future<void> clearNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void markAsTaken(int index) {
    setState(() {
      medicines[index]['taken'] = true;
      medicines[index]['highlighted'] = false;
    });
    showNotification(
        "You have taken your ${medicines[index]['time']} medicine.");
  }

  void markAsNotTaken(int index) {
    setState(() {
      medicines[index]['taken'] = false;
    });
    clearNotification();
  }

  void highlight(int index) {
    setState(() {
      medicines[index]['highlighted'] = true;
    });
    showNotification(
        "Remember to take your ${medicines[index]['time']} medicine!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8F0F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text(
          "Medicine Schedule",
          style: TextStyle(color: Color(baseRootColour)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: medicines.asMap().entries.map((entry) {
              int index = entry.key;
              var medicine = entry.value;

              return Neumorphic(
                margin: const EdgeInsets.only(bottom: 16.0),
                style: NeumorphicStyle(
                  color: medicine['highlighted']
                      ? Colors.green.shade200
                      : Colors.white,
                  depth: medicine['taken'] ? 0 : 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${medicine['time']} Medication",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(baseRootColour),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: medicine['medications'].map<Widget>((med) {
                          return Text("- ${med['name']} (${med['dose']})",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54));
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!medicine['taken']) ...[
                            NeumorphicButton(
                              onPressed: () => markAsTaken(index),
                              style: const NeumorphicStyle(
                                color: Colors.blue,
                                depth: 3,
                              ),
                              child: const Text(
                                "Taken",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            NeumorphicButton(
                              onPressed: () => highlight(index),
                              style: const NeumorphicStyle(
                                color: Colors.orange,
                                depth: 3,
                              ),
                              child: const Text(
                                "Highlight",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ] else ...[
                            NeumorphicButton(
                              onPressed: () => markAsNotTaken(index),
                              style: const NeumorphicStyle(
                                color: Colors.red,
                                depth: 3,
                              ),
                              child: const Text(
                                "Not Taken",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ]
                        ],
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  bool _obscurePassword = true;
  String _password = "********";

  void _generatePassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*";
    final rand = Random();
    setState(() {
      _password =
          List.generate(10, (index) => chars[rand.nextInt(chars.length)])
              .join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE8F0F9),
        title: const Text(
          "BIOSYNC",
          style: TextStyle(color: Color(baseRootColour)),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: const Color(0xffE8F0F9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code Placeholder
            Neumorphic(
              style: NeumorphicStyle(
                depth: 8,
                intensity: 0.6,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/image_qr.png', // Replace with actual QR image path
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Password Reveal Segment
            Neumorphic(
              style: NeumorphicStyle(
                depth: 5,
                intensity: 0.8,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _obscurePassword ? "********" : _password,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                          if (!_obscurePassword) {
                            _generatePassword();
                          }
                        });
                      },
                      style: const NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: 5,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: Color(0xffE8F0F9),
                      ),
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(baseRootColour),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
