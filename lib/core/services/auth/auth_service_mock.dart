import 'package:mockito/mockito.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import 'auth_service.dart';

class AuthServiceMock extends Mock implements AuthService {
  User _currentUser;
  @override
  User get currentUser => _currentUser;

  // The service to use for requests
//  HttpService _http = locator<HttpService>();

  // Service for persisting data
  IStorageUtil _storage = locator<IStorageUtil>();

  // The service for directing user to the home screen
  NavigationService _navigationService = locator<NavigationService>();

  Future authUser(String url, Map<String, String> params) async {
    try {
      // Send the request to the API with the data
      Map response = await Future.value({}); // TODO: Add mock data

      // Check if the status is true
      if (response.containsKey('status') && response['status']) {

      } else {
        throw Exception(response.containsKey('message')
            ? response['message']
            : 'Bad response: $response');
      }

      return response;
    } on Exception catch (e, s) {
      Logger.e('Error authenticating user', e: e, s: s);
      throw e;
    }
  }

  @override
  Future<void> signUpWithPhoneNumber(
      String phoneNumber,
      String password,
      ) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      // Send user details to server to create an entry for the user
      Map response = await authUser(
        ApiRoutes.authentication_login,
        {'phone_number': phoneNumber, 'password:': password},
      );

      // Build the user object from the API response
      _currentUser = User.fromJson(response['local'])
        ..id = response['_id']
      ;

    } on Exception catch(e, s) {
      Logger.e('AuthService: Error signing up', e: e, s: s);
      throw AuthException('Error signing up');
    }

    // Take the user to the home screen
    _storage.saveIfAbsent(AppPreferenceKey.USER_SIGNED_IN, '');
    _navigationService.clearStackAndShow(Routes.homeViewRoute, arguments: {'signup': true});
  }

  @override
  Future<void> signInWithPhoneNumber(
      String phoneNumber,
      String password,
      ) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      //  // fetch current user from server
      Map response = await authUser(
        ApiRoutes.authentication_register,
        {'phone_number': phoneNumber, 'password:': password},
      );

      // Build the user object from the API response
      _currentUser = User.fromJson(response['local'])
        ..id = response['_id']
      ;
    } on Exception {
      Logger.e('AuthService: Error signing in');
      throw AuthException('Error signing in');
    }

    // Take the user to the home screen
    _storage.saveIfAbsent(AppPreferenceKey.USER_SIGNED_IN, '');
    _navigationService.clearStackAndShow(Routes.homeViewRoute, arguments: {'signup': false});
  }

  @override
  Future<void> signOut() async {
//    await Future.delayed(Duration(milliseconds: 250));
    _currentUser = null;
    _storage.removeKey(AppPreferenceKey.USER_SIGNED_IN);
  }

  @override
  Future<bool> get isUserLoggedIn async {
    // check server for login status
//    await Future.delayed(Duration(seconds: 1));

    return _currentUser != null;
  }
}
