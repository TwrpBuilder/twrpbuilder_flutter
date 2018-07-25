// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' deferred as messages_ar;
import 'messages_az.dart' deferred as messages_az;
import 'messages_en.dart' deferred as messages_en;
import 'messages_tr.dart' deferred as messages_tr;
import 'messages_messages.dart' deferred as messages_messages;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => messages_ar.loadLibrary(),
  'az': () => messages_az.loadLibrary(),
  'en': () => messages_en.loadLibrary(),
  'tr': () => messages_tr.loadLibrary(),
  'messages': () => messages_messages.loadLibrary(),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'az':
      return messages_az.messages;
    case 'en':
      return messages_en.messages;
    case 'tr':
      return messages_tr.messages;
    case 'messages':
      return messages_messages.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
