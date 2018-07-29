import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application.dart';
import 'json_translations.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String language = _prefs.getString('language') ?? 'en';
  return runApp(new MyApp(defaultLanguage: language));
}

class MyApp extends StatefulWidget {
  MyApp({
    this.defaultLanguage,
  });

  final String defaultLanguage;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale defaultLocale;
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    defaultLocale = Locale(widget.defaultLanguage);

    _localeOverrideDelegate = new SpecificLocalizationDelegate(defaultLocale);
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TWRP Builder',
      theme: ThemeData(fontFamily: 'Raleway'),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      home: new GoogleLoginPage(),
    );
  }
}
