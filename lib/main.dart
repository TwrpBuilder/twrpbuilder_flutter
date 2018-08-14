import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application.dart';
import 'json_translations.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  MaterialPageRoute.debugEnableFadingRoutes = true; ///Deprecated code - will be removed once Flutter devs fix the issue
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String language = _prefs.getString('language') ?? 'en';
  String theme = _prefs.getString('theme') ?? 'dark';
  Brightness brightness;
  if (theme == 'light') {
    brightness = Brightness.light;
  } else {
    brightness = Brightness.dark;
  }

  return runApp(new MyApp(
    defaultLanguage: language,
    defaultTheme: brightness,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({
    this.defaultLanguage,
    this.defaultTheme,
  });

  final String defaultLanguage;
  final Brightness defaultTheme;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale defaultLocale;
  Brightness defaultBrightness;
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();

    defaultLocale = Locale(widget.defaultLanguage);
    defaultBrightness = widget.defaultTheme;

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
      theme: ThemeData(fontFamily: 'Raleway', brightness: defaultBrightness),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      home: new GoogleLoginPage(),
      locale: defaultLocale,
    );
  }
}
