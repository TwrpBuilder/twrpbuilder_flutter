import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twrp_builder/fragments/rejected_fagment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twrp_builder/fragments/incomplete_fragment.dart';
import 'package:twrp_builder/pages/login_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String name = "";
String email = "";
String nn;
String ee;

class SettingsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  //LoadUser loadUser = new LoadUser();
  final Future<FirebaseUser> ssd = LoadUser._loadUserData();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text("Settings"),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class LoadUser {
  //LoadUser loadUser;
//  LoadUser(){
//    loadUser = new LoadUser();
//  }

  static Future<FirebaseUser> _loadUserData() async{
    FirebaseUser user = await _auth.currentUser();
    name = user.displayName;
    email = user.email;
    return user;
  }
}