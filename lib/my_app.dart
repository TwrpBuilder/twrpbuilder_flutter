import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scope_model_wrapper.dart';
import 'translations.dart';
import 'pages/login_page.dart';
import 'translation_strings.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => MaterialApp(
        locale: model.appLocal,
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), //English
          const Locale('ar', ''), //Arabic
          const Locale('az', ''), //Azerbaijani
          const Locale('tr', ''), //Turkish
        ],
        debugShowCheckedModeBanner: false,
        //title: Translations.of(context).appName, //causing problems
        title: 'TWRP Builder',
        home: new LoginPage(),
      ),
    );
  }

}