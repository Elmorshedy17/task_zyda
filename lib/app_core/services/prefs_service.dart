import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService _instance;
  static SharedPreferences _preferences;

  static const String APP_LANGUAGE_KEY = 'language_code';
  static const String APP_COUNTRY_CODE = 'countryCode';
  static const String APP_COUNTRY_NAME = 'countryName';
  static const String HAS_CHOSEN_LANGUAGE = 'hasChosenLanguage';
  static const String SIGN_UP_KEY = 'signedUp';
  static const String LOG_IN_KEY = 'loggedIn';
  static const String City_id = 'cityID';
  static const String NOTIFICATION_FlAG = 'notificationFlag';
  static const String NOTIFICATION_COUNT = 'notificationCount';
  static const String NOTIFICATION_SEEN = 'notificationSeen';
  static const String IS_NEARBY_FIRST_TIME_OPINING = 'isNearbyFirstTimeOpining';
  // static const String IS_BACK_TO_ONLINE = 'isBackToOnline';
  static const String USER_OBJ = 'user';
  static const String CART_OBJ = 'cart';
  static const String USER_PASSWORD = 'userPassword';
  static const String USER_LOCATION = 'userLocation';
  static const String HAS_WELCOME_SEEN = 'hasWelcomeSeen';
  static const String HAS_SIGN_IN_SEEN = 'hasSignInSeen';
  // static const String HAS_SIGN_IN_SEEN = 'hasSignInSeen';
  static const String APPLE_USER = 'appleUser';

  static Future<PrefsService> getInstance() async {
    if (_instance == null) {
      _instance = PrefsService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromPrefs(String key) {
    var value = _preferences.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToPrefs<T>(String key, T content) {
    // print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  // remove from Prefs
  void _removeFromPrefs(String key) {
    _preferences.remove(key);
  }

  // clear all Prefs
  void clearAllPrefs() {
    _preferences.clear();
  }

// /////////////////////////////////////////////////////////////////////////////////
//   bool get notificationFlag => _getFromPrefs(NOTIFICATION_FlAG) ?? true;
//   set notificationFlag(bool value) => _saveToPrefs(NOTIFICATION_FlAG, value);
//   bool get notificationSeen => _getFromPrefs(NOTIFICATION_SEEN) ?? false;
//   set notificationSeen(bool value) => _saveToPrefs(NOTIFICATION_SEEN, value);
//   int get notificationCount => _getFromPrefs(NOTIFICATION_COUNT) ?? 0;
//   set notificationCount(int value) => _saveToPrefs(NOTIFICATION_COUNT, value);
// ////////////////////////////////////////////////////////////////////////////////
//   bool get hasSignedUp => _getFromPrefs(SIGN_UP_KEY) ?? false;
//   set hasSignedUp(bool value) => _saveToPrefs(SIGN_UP_KEY, value);
// ////////////////////////////////////////////////////////////////////////////////
//   bool get hasLoggedIn => _getFromPrefs(LOG_IN_KEY) ?? false;
//   set hasLoggedIn(bool value) => _saveToPrefs(LOG_IN_KEY, value);
// ////////////////////////////////////////////////////////////////////////////////
//   bool get isNearbyFirstTimeOpining =>
//       _getFromPrefs(IS_NEARBY_FIRST_TIME_OPINING) ?? true;
//   set isNearbyFirstTimeOpining(bool value) =>
//       _saveToPrefs(IS_NEARBY_FIRST_TIME_OPINING, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for notificationsCount
// //  int get notificationsCount => _getFromPrefs(NOTIFICATIONS_COUNT) ?? 0;
// //  // setter for notificationsCount
// //  set notificationsCount(int value) => _saveToPrefs(NOTIFICATIONS_COUNT, value);
// //  // remove notificationsCount
// //  removeNotificationsCount() => _removeFromPrefs(NOTIFICATIONS_COUNT);
// ////////////////////////////////////////////////////////////////////////////////
  // getter for App language.
  String get appLanguage => _getFromPrefs(APP_LANGUAGE_KEY);
  // setter for App language.
  set appLanguage(String value) => _saveToPrefs(APP_LANGUAGE_KEY, value);
  /////////////////////////////////////////////////////////////////////////////////
  // getter for country code.
  String get countryCode => _getFromPrefs(APP_COUNTRY_CODE);
  // setter for country code.
  set countryCode(String value) => _saveToPrefs(APP_COUNTRY_CODE, value);
// ////////////////////////////////////////////////////////////////////////////////
//   bool get hasChosenLanguage => _getFromPrefs(HAS_CHOSEN_LANGUAGE) ?? false;
//   set hasChosenLanguage(bool value) => _saveToPrefs(HAS_CHOSEN_LANGUAGE, value);
// ////////////////////////////////////////////////////////////////////////////////
//   bool get hasWelcomeSeen => _getFromPrefs(HAS_WELCOME_SEEN) ?? false;
//   set hasWelcomeSeen(bool value) => _saveToPrefs(HAS_WELCOME_SEEN, value);
//   ////////////////////////////////////////////////////////////////////////////////
//   bool get hasSignInSeen => _getFromPrefs(HAS_SIGN_IN_SEEN) ?? false;
//   set hasSignInSeen(bool value) => _saveToPrefs(HAS_SIGN_IN_SEEN, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // bool get isBackToOnline => _getFromPrefs(IS_BACK_TO_ONLINE) ?? false;
//   // set isBackToOnline(bool value) => _saveToPrefs(IS_BACK_TO_ONLINE, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // bool get hasConnection => _getFromPrefs(HAS_CONNECTION) ?? false;
//   // set hasConnection(bool value) => _saveToPrefs(HAS_CONNECTION, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for USER_OBJECT.
//   User get userObj {
//     var userJson = _getFromPrefs(USER_OBJ);
//     if (userJson == null) {
//       return null;
//     }
//
//     return User.fromJson(json.decode(userJson));
//   }
//
//   // setter for USER_OBJECT.
//   set userObj(User userToSave) {
//     _saveToPrefs(USER_OBJ, json.encode(userToSave.toJson()));
//   }
//
//   // // Remove UserObj
//   removeUserObj() => _removeFromPrefs(USER_OBJ);
// //////////////////////////////////////////////////
//
//   UserLocation get userLocation => _getFromPrefs(USER_LOCATION) ?? null;
//   set userLocation(UserLocation userLocation) =>
//       _saveToPrefs(USER_LOCATION, userLocation);
//
//
//   ///////////////////////////////////////////////////////////////
//   // Apple User Info
//   AppleUser get appleUser=> _getFromPrefs(APPLE_USER)??null;
//   set appleUser (AppleUser appleUser)=>_saveToPrefs(APPLE_USER, appleUser);
//
// ////////////////////////////////////////////////////////////
//   // getter for CART_OBJECT.
//   LocalCart get cartObj {
//     var cartJson = _getFromPrefs(CART_OBJ);
//     if (cartJson == null) {
//       return LocalCart();
//     }
//
//     return LocalCart.fromJson(json.decode(cartJson));
//   }
//
//   // setter for CART_OBJECT.
//   set cartObj(LocalCart cartToSave) {
//     _saveToPrefs(CART_OBJ, json.encode(cartToSave.toJson()));
//   }
//
//   removeCartObj() => _removeFromPrefs(CART_OBJ);
}
