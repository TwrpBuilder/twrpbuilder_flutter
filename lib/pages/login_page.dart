import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
String name = "";
String email = "";
String userProfile = "";

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: new GoogleLoginPage(),
    );
  }
}

class GoogleLoginPage extends StatefulWidget {
  @override
  _GoogleLoginPageState createState() => new _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _gSAuth = await googleUser.authentication;
    final FirebaseUser _user = await _auth.signInWithGoogle(
      idToken: _gSAuth.idToken,
      accessToken: _gSAuth.accessToken,
    );

    assert(_user != null);
    assert(!_user.isAnonymous);
    assert(_user.email != null);
    assert(_user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();

    if (currentUser.email != null) {
      //Navigator.pop(context);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new HomePage();
      }));
      name = currentUser.displayName;
      email = currentUser.email;
      userProfile = currentUser.photoUrl;
    }
    assert(_user.uid == currentUser.uid);
    return _user;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway')),
        title: new Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: new FlatButton.icon(
              onPressed: _signInWithGoogle,
              icon: new Icon(Icons.email),
              textColor: Colors.white,
              color: Colors.blue,
              label: Text("Sign in with Google"))),
    );
  }
}
