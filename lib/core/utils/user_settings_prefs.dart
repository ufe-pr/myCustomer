// This class will store the user  settings preferences.
//It will also help with persisiting the settings
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesHelper{
  static SharedPreferencesHelper _instance;

  factory SharedPreferencesHelper() => _instance ??= new SharedPreferencesHelper._();
  SharedPreferencesHelper._();

  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _kUserPin='userpin';
  final String _kNotificationsPrefs="allowNotifications";
  final String _kLightMode="setLightMode";
  final String _kLanguageCode ="language";
  final String _kNewsletterPrefs="receiveNewsletters";
  final String _kSpecialOffersPrefs="receiveSpecialOffers";
  final String _kUpdatesPrefs="receiveUpdates";

  

  /// ------------------------------------------------------------
  /// Methods that saves and returns the user encrypted password
  /// ------------------------------------------------------------
  Future<bool> saveUserPin(String pin,SharedPreferences pref) async{

    return  pref.setString(_kUserPin, pin);

  }
  Future<String>getUserPin(SharedPreferences pref)async{
   return pref.getString(_kUserPin);

 }

 Future<void>removeUserPin(SharedPreferences pref) async{
   pref.remove(_kUserPin);
 }

  Future<bool> getAllowsNotifications(SharedPreferences prefs) async {
  	return prefs.getBool(_kNotificationsPrefs) ?? true;
  }

  Future<bool> setAllowsNotifications(bool value , SharedPreferences prefs) async {
	return prefs.setBool(_kNotificationsPrefs, value);
  }


  Future<String> getLanguageCode(SharedPreferences pref) async {
    return pref.getString(_kLanguageCode) ?? 'en';
  }
  
  Future<bool> setLanguageCode(String value, SharedPreferences prefs) async {
    return prefs.setString(_kLanguageCode, value);
  }


   Future<bool> getAllowsNewsletters(SharedPreferences prefs) async {
  	return prefs.getBool(_kNewsletterPrefs) ?? false;
  }

  Future<bool> setAllowsNewsletter(bool value , SharedPreferences prefs) async {
	return prefs.setBool(_kNewsletterPrefs, value);
  }

   Future<bool> getAllowsUpdates(SharedPreferences prefs) async {
  	return prefs.getBool(_kUpdatesPrefs) ?? true;
  }

  Future<bool> setAllowsUpdates(bool value , SharedPreferences prefs) async {
	return prefs.setBool(_kUpdatesPrefs, value);
  }

   Future<bool> getAllowsLightMode(SharedPreferences prefs) async {
  	return prefs.getBool(_kLightMode) ?? true;
  }

  Future<bool> setAllowsLightMode(bool value , SharedPreferences prefs) async {
	return prefs.setBool(_kLightMode, value);

  }

   Future<bool> getAllowsSpecialOffers(SharedPreferences prefs) async {
  	return prefs.getBool(_kSpecialOffersPrefs) ?? false;
  }

  Future<bool> setAllowsSpecialOffers(bool value , SharedPreferences prefs) async {
	return prefs.setBool(_kSpecialOffersPrefs, value);
  }

}