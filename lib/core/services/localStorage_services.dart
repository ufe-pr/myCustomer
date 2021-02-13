import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  static const String DarkModeKey = 'darkmode';
  static const String UserPin='userpin';
  static const String NotificationsPrefs="allowNotifications";
  static const String LanguageCode ="language";
  static const String NewsletterPrefs="receiveNewsletters";
  static const String SpecialOffersPrefs="receiveSpecialOffers";
  static const String UpdatesPrefs="receiveUpdates";

  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromDisk(String key) {
  var value  = _preferences != null ? _preferences.get(key) : null;
  print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
  return value;
}

void _saveToDisk<T>(String key, T content){
  print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

  if(content is String) {
    _preferences.setString(key, content);
  }
  if(content is bool) {
    _preferences.setBool(key, content);
  }
  if(content is int) {
    _preferences.setInt(key, content);
  }
  if(content is double) {
    _preferences.setDouble(key, content);
  }
  if(content is List<String>) {
    _preferences.setStringList(key, content);
  }
}

  // set darkMode(bool value) => _saveToDisk(DarkModeKey, value);
  set darkMode(bool value){
     _saveToDisk(DarkModeKey, value);
  }
  bool get darkMode => _getFromDisk(DarkModeKey) ?? false;

  set setNotification(bool value)=> _saveToDisk(NotificationsPrefs,value);
  bool get notification => _getFromDisk(NotificationsPrefs) ?? true;

  set newsletter(bool value)=>_saveToDisk(NewsletterPrefs,value);
  bool get newsletter => _getFromDisk(NewsletterPrefs) ?? false;

  set updates(bool value) => _saveToDisk(UpdatesPrefs,value);
  bool get updates => _getFromDisk(UpdatesPrefs) ?? true;

  set specialOffers(bool value) => _saveToDisk(SpecialOffersPrefs,value);
  bool get specialOffers => _getFromDisk(SpecialOffersPrefs) ?? false;

  set userPin(String value) => _saveToDisk(UserPin,value);
  String get userPin => _getFromDisk(UserPin) ?? "false";

}