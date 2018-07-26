import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login_page.dart';
import 'json_translations.dart';
import 'application.dart';
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Locale defaultLocale = null ?? Locale('en');
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<Locale> _language;
  SpecificLocalizationDelegate _loaleOverrideDelegate;

  @override
  void initState() {
    super.initState();

    _language = _prefs.then((SharedPreferences prefs){
      setState(() {
        defaultLocale = Locale(prefs.getString('language')) ?? Locale('en');
      });
      print(defaultLocale);
      _loaleOverrideDelegate = new SpecificLocalizationDelegate(defaultLocale);
    });


    applic.onLocaleChanged = onLocaleChange;
    applic.onLocaleChanged(defaultLocale);
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _loaleOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TWRP Builder',
      theme: ThemeData(
          fontFamily: 'Raleway'
      ),
      localizationsDelegates: [
        _loaleOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      home: new LoginPage(),
    );
  }
}