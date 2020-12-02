import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../app_core.dart';

class AppLanguageManager extends Manager {
  final BehaviorSubject<Locale> _localSubject =
      BehaviorSubject.seeded(Locale('en'));
  Stream<Locale> get locale$ => _localSubject.stream;
  Sink<Locale> get inLocale => _localSubject.sink;
  Locale get currentLocale => _localSubject.value;

  // Locale _appLocale = Locale('en');

  // Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = locator<PrefsService>();
    if (prefs.appLanguage == null) {
      // _appLocale = Locale('en');
      inLocale.add(Locale('en'));
      return Null;
    }
    // _appLocale = Locale(prefs.appLanguage);
    inLocale.add(Locale(prefs.appLanguage));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = locator<PrefsService>();
    // if (_appLocale == type) {
    //   return;
    // }
    if (currentLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      // _appLocale = Locale("ar");
      prefs.appLanguage = 'ar';
      prefs.countryCode = '';
      inLocale.add(Locale("ar"));
    } else {
      // _appLocale = Locale("en");
      prefs.appLanguage = 'en';
      prefs.countryCode = 'US';
      inLocale.add(Locale("en"));
    }
  }

  @override
  void dispose() {
    _localSubject.close();
  }
}
