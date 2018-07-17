import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text("Settings"),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
