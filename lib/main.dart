
import 'package:flutter/material.dart';

import 'login_register.dart';
import 'home.dart';
import 'otp.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.indigo),
      home: Login(),
    );
  }
}

