import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<String> supportedLanguages = ['ar', 'en'];

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));
  LocaleChangeCallback onLocaleChanged;

  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();
}

APPLIC applic = new APPLIC();