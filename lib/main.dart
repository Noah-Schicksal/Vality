import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vality/login.dart';
import 'package:vality/Home.dart'; 
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/notify/notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vality', 
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.black38,  
          secondary: Colors.green, 
        ),
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
