import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  static final String oneSignalAppId = "2323b7fb-1ea0-4145-a0b0-0f6a3caadbaf";

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '뒤로 돌아가기',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 25,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading:
            ElevatedButton(
              child: const Icon(
                Icons.arrow_back
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      ),
      body: Center(


           child: Image.asset(
             'images/001.gif' ,
              fit: BoxFit.fill,
            ),

        ),

    );
  }
}
