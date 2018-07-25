import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  static bool defaultValue = null ?? false;
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _notification;

  Future<Null> _loadPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final bool notification = (prefs.getBool('notification') ?? false);

    setState(() {
      _notification = prefs.setBool("notification", notification).then((bool success) {
        return notification;
      });
    });
  }

  static Future<Null> _savePrefs(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("notification", value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notification = _prefs.then((SharedPreferences prefs){
      setState(() {
        defaultValue = prefs.getBool("notification") ?? false;
      });
      print(defaultValue);
      return defaultValue;
    });
  }

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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Language"),
            onTap: (){},
          ),
          ListTile(
            title: Text("Check for update"),
            onTap: () {},
          ),
          CheckboxListTile(
            value: defaultValue,
            onChanged: (bool value) {
              setState(() {
                defaultValue = value;
                _savePrefs(value);

                if (value == true) {
                  
                } else {

                }
              });
            },
            title: Text("Disable Notification"),
          )
        ],
      )
    );
  }
}


