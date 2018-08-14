import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../fragments/completed_fragment.dart';
import '../fragments/contact_fragment.dart';
import '../fragments/contributers_fragment.dart';
import '../fragments/home_fragment.dart';
import '../fragments/incomplete_fragment.dart';
import '../fragments/rejected_fragment.dart';
import '../fragments/team_fragment.dart';
import '../json_translations.dart';
import 'login_page.dart';
import 'settings_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  //bool _rootAccess = false;
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    //initRootRequest();
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
    await _googleSignIn.signOut().whenComplete(() {
      exit(0);
    });
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
            title: Text(Translations.of(context).text('quit')),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close')),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _quit();
                  },
                  child: Text(Translations.of(context).text('quit'))),
            ],
          );
        });
  }

  Future<Null> _showAboutDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AboutDialog(
            applicationName: 'Twrp Builder',
            applicationVersion: '1.2',
            applicationLegalese: 'MIT License',
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Based on',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('Flutter'),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Text(
                      'Developed by',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('TWRP Builder Team')
                  ],
                ),
              )
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
        case 'About':
          _showAboutDialog();
          break;
      }
    });
  }

//  Future<void> initRootRequest() async {
//    bool rootAccess = await TwrpbuilderPlugin.rootAccess;
//    setState(() {
//      _rootAccess = rootAccess;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerItems = [
      new DrawerItem(Translations.of(context).text('home'), Icons.home),
      new DrawerItem(Translations.of(context).text('incomplete'), Icons.sync),
      new DrawerItem(Translations.of(context).text('completed'), Icons.done),
      new DrawerItem(Translations.of(context).text('rejected'), Icons.block),
      new DrawerItem(Translations.of(context).text('contributors'), Icons.code),
      new DrawerItem(
          Translations.of(context).text('ourTeam'), Icons.group_work),
      new DrawerItem(
          Translations.of(context).text('reach_us'), Icons.info_outline),
    ];

    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
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
        title: new Text(drawerItems[_selectedDrawerIndex].title),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme:
            TextTheme(title: TextStyle(fontSize: 20.0, fontFamily: 'Raleway')),
        centerTitle: true,
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
                  fontSize: 15.0,
                  fontFamily: 'Raleway',
                ),
              ),
              accountEmail: new Text(
                email,
                style: TextStyle(fontSize: 14.0, fontFamily: 'Raleway'),
              ),
              currentAccountPicture: Container(
                width: 96.0,
                height: 96.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(userProfile))),
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Settings', icon: Icons.settings),
  const Choice(title: 'Logout', icon: Icons.exit_to_app),
  const Choice(title: 'Quit', icon: Icons.exit_to_app),
  const Choice(title: 'About', icon: Icons.info)
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
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
