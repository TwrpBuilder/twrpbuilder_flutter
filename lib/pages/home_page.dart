import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twrp_builder/fragments/completed_fragment.dart';
import 'package:twrp_builder/fragments/contact_fragment.dart';
import 'package:twrp_builder/fragments/contributers_fragment.dart';
import 'package:twrp_builder/fragments/home_fragment.dart';
import 'package:twrp_builder/fragments/incomplete_fragment.dart';
import 'package:twrp_builder/fragments/rejected_fagment.dart';
import 'package:twrp_builder/fragments/team_fragment.dart';
import 'package:twrp_builder/main.dart';
import 'package:twrp_builder/pages/login_page.dart';
import 'package:twrp_builder/pages/settings_page.dart';
import 'package:twrpbuilder_plugin/twrpbuilder_plugin.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Incomplete", Icons.sync),
    new DrawerItem("Completed", Icons.done),
    new DrawerItem("Rejected", Icons.block),
    new DrawerItem("Contributers", Icons.code),
    new DrawerItem("Our Team", Icons.group_work),
    new DrawerItem("Reach Us", Icons.info_outline),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool _rootAccess = false;
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    initRootRequest();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeFragment();
      case 1:
        return new IncompleteFragment();
      case 2:
        return new CompletedFragment();
      case 3:
        return new RejectedFragment();
      case 4:
        return new ContributeFragment();
      case 5:
        return new TeamFragment();
      case 6:
        return new ContactFragment();

      default:
        return new Text("Error");
    }
  }

  //Logout user and exit the app
  Future<void> _logOutUser() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut().whenComplete(() {exit(0);});
//    Navigator.pushReplacement(context,
//        new MaterialPageRoute(builder: (BuildContext context) {
//      return new MyApp();
//    }));
    //exit(0);
  }

  Future<void> _quit() async {
    exit(0);
  }

  Future<Null> _showQuitDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Quit!"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close")
              ),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _quit();
                  },
                  child: Text("Quit")),
            ],
          );
        });
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
      switch (_selectedChoice.title) {
        case 'Settings':
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new SettingsPage();
          }));
          break;
        case 'Logout':
          _logOutUser();
          break;
        case 'Quit':
          _showQuitDialog();
          break;
      }
    });
  }

  Future<void> initRootRequest() async {
    bool rootAccess = await TwrpbuilderPlugin.rootAccess;

    setState(() {
      _rootAccess = rootAccess;
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway')),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontFamily: 'Raleway',
                ),
              ),
              accountEmail: new Text(
                email,
                style: TextStyle(
                    color: Colors.black, fontSize: 14.0, fontFamily: 'Raleway'),
              ),
              currentAccountPicture: Container(
                width: 96.0,
                height: 96.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(userProfile))),
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
            ),
            new Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

//class LoadUser {
//  //LoadUser loadUser;
////  LoadUser(){
////    loadUser = new LoadUser();
////  }
//
//  static Future<FirebaseUser> _loadUserData() async{
//    FirebaseUser user = await _auth.currentUser();
//    name = user.displayName;
//    email = user.email;
//    return user;
//  }
//}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Settings', icon: Icons.settings),
  const Choice(title: 'Logout', icon: Icons.exit_to_app),
  const Choice(title: 'Quit', icon: Icons.exit_to_app),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
