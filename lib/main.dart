import 'package:flutter/material.dart';
import 'package:twrp_builder/pages/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Twrp Builder',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: new LoginPage(),
    );
  }
}