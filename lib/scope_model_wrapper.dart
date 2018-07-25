import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_app.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
Future<String> _language;
class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MyApp(),
    );
  }
}

class AppModel extends Model {

  static Locale selectedLanguage = null ?? Locale('en');


  static Future<String> _language = _prefs.then((SharedPreferences prefs) {
    selectedLanguage = prefs.getString('language') ?? Locale('en');
    print(selectedLanguage);
  });

  Future<String> _ll = _language;

  Locale _appLocale = selectedLanguage;
  Locale get appLocal => _appLocale ?? selectedLanguage;

  void changeDirection() {
//    if (_appLocale == Locale("en")) {
//      _appLocale = Locale("ar");
//    } else {
//      _appLocale = Locale("en");
//    }
    _appLocale = selectedLanguage;
    print(_appLocale);
    notifyListeners();
  }

  void changeLanguage(String language) {
    _appLocale = Locale(language);

    notifyListeners();
  }
}
