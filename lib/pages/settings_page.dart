import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';

import '../application.dart';
import '../json_translations.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static bool defaultValue = null ?? false;
  static Locale defaultLocale = Locale('en');
  static String defaultLanguage = 'English';
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _notification;

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<Null> _checkStoragePermissions(String url) async {
    bool storageStatus = await SimplePermissions
        .checkPermission(Permission.WriteExternalStorage);
    //print(storageStatus);
    if (!storageStatus) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Grant permissions'),
              content: Text(
                  'We need storage permission to download and store the update in external storage'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CLOSE',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                new FlatButton(
                  onPressed: () {
                    _startDownloadTask(url);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'GRANT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          });
    } else {
      _startDownloadTask(url);
    }
  }

  Future<Null> _startDownloadTask(String url) async {
    bool requestStatus = await SimplePermissions
        .requestPermission(Permission.WriteExternalStorage);
    if (requestStatus) {
      String _path = await _findLocalPath();

      final taskId = await FlutterDownloader.enqueue(
          url: url, savedDir: _path, showNotification: true);

      FlutterDownloader.registerCallback((id, status, progress) {
        print(
            'Download task ($id) is in status ($status) and process ($progress)');
      });
    }
  }

  Future<Null> _loadPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final bool notification = (prefs.getBool('notification') ?? false);

    setState(() {
      _notification =
          prefs.setBool("notification", notification).then((bool success) {
        return notification;
      });
    });
  }

  static Future<Null> _savePrefs(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("notification", value);
  }

  static Future<Null> _saveLanguagePrefs(String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("language", value);
    //defaultLanguage = value;
  }

  void showFlushBar(BuildContext context) {
    Flushbar(
      title: 'Restart app',
      message: Translations.of(context).text('restart_change'),
      backgroundGradient: LinearGradient(
          colors: [Colors.blueGrey, Colors.lightBlue],
          tileMode: TileMode.clamp),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  Future<Null> showLanguageDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(Translations.of(context).text('select_lang')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    title: Text("Arabic"),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Arabic';
                        _saveLanguagePrefs('ar');
                        applic.onLocaleChanged(new Locale('ar', ''));
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Azerbaijani'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Azerbaijani';
                        _saveLanguagePrefs('tr');
                        applic.onLocaleChanged(new Locale('tr', ''));
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text("English"),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'English';
                        _saveLanguagePrefs('en');
                        applic.onLocaleChanged(new Locale('en', ''));
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('French'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'French';
                        _saveLanguagePrefs('en');
                        applic.onLocaleChanged(
                            new Locale('en', '')); //for now load english
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Italian'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Italian';
                        _saveLanguagePrefs('en');
                        applic.onLocaleChanged(
                            new Locale('en', '')); //for now load english
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Romanian'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Romanian';
                        _saveLanguagePrefs('en');
                        applic.onLocaleChanged(
                            new Locale('en', '')); //for now load english
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Spanish'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Spanish';
                        _saveLanguagePrefs('en');
                        applic.onLocaleChanged(
                            new Locale('en', '')); //for now load english
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Turkish'),
                    onTap: () {
                      setState(() {
                        defaultLanguage = 'Turkish';
                        _saveLanguagePrefs('tr');
                        applic.onLocaleChanged(new Locale('tr', ''));
                        Navigator.of(context).pop();
                        showFlushBar(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notification = _prefs.then((SharedPreferences prefs) {
      setState(() {
        defaultValue = prefs.getBool("notification") ?? false;
        //defaultLocale = Locale(prefs.getString('language')) ?? Locale('en');
      });
      return defaultValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(Translations.of(context).text('settings')),
        textTheme:
            TextTheme(title: TextStyle(fontSize: 20.0, fontFamily: 'Raleway')),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(Translations.of(context).text('language')),
            subtitle: Text(defaultLanguage),
            onTap: () {
              showLanguageDialog();
            },
          ),
          ListTile(
            title: Text(Translations.of(context).text('check_for_update')),
            onTap: () {},
          ),
          CheckboxListTile(
            value: defaultValue,
            onChanged: (bool value) {
              setState(() {
                defaultValue = value;
                _savePrefs(value);

                if (value) {
                  FirebaseMessaging().unsubscribeFromTopic("pushNotifications");
                } else {
                  FirebaseMessaging().subscribeToTopic("pushNotifications");
                }
              });
            },
            title: Text(Translations.of(context).text('disable_notification')),
          )
        ],
      ),
    );
  }
}
