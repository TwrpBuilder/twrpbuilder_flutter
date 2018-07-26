import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:twrp_builder/pages/login_page.dart';
import 'json_translations.dart';
import 'application.dart';
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _loaleOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _loaleOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
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