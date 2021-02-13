import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/exceptions/network_exception.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  User _currentUser;
  @override
  User get currentUser => _currentUser;

  void updateCurrentUser(User newUser) {
    _currentUser = newUser;
  }


  // The service to use for requests
  HttpService _http = locator<HttpService>();
  // Service for persisting data
  IStorageUtil _storage = locator<IStorageUtil>();
  // The service for directing user to the home screen
 NavigationService _navigationService = locator<NavigationService>();
 final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();


  Future authUser(String url, Map<String, dynamic> params) async {
    try {
      // Send the request to the API with the data
      Map response = await _http.postHttp(url, params);
      Logger.d('Response from auth is: $response');
      // Check if the status is true
      if (response.containsKey('success') && response['success']) {
        _http.setHeader({'x-access-token': response['data']['user']['api_token']});
      } else {
        throw AuthException(response.containsKey('message')
            ? response['message']
            : 'Bad response from server');
      }
      await StoreRepository.updateStores();
      return response;
    } on NetworkException catch(e, s) {
      Logger.e('Error authenticating user: ${e.message}', e: e, s: s);
      throw AuthException(e.message);
    } on AuthException catch(e, s) {
      Logger.e('Error authenticating user: ${e.message}', e: e, s: s);
      throw e;
    } catch (e, s) {
      Logger.e('Error authenticating user with parameters: $params', e: e, s: s);
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
        ApiRoutes.authentication_register,
        {'phone_number': int.parse(phoneNumber), 'password': password},
      );

      // Build the user object from the API response
      _currentUser = User.fromJson(response['data']['user']['local'])
        ..id = response['data']['user']['_id']
      ;

    } on NetworkException catch(e, s) {
      Logger.e('Error authenticating user: ${e.message}', e: e, s: s);
      throw AuthException(e.message);
    } on AuthException catch(e, s) {
      Logger.e('AuthService: Error signing up', e: e, s: s);
      throw e;
    } catch(e, s) {
      Logger.e('Unknown Exception while authenticating', e: e, s: s);
      throw AuthException('Error signing up');
    }

    // Take the user to the home screen
    await _storage.saveIfAbsent(AppPreferenceKey.USER_SIGNED_IN, '');
    await _storage.saveString(AppPreferenceKey.USER_PHONE, phoneNumber);
    await _storage.saveString(AppPreferenceKey.USER_PASS, password);
    await _storage.saveString(AppPreferenceKey.USER_ID, currentUser.id);
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
        ApiRoutes.authentication_login,
        {'phone_number': int.parse(phoneNumber), 'password': password},
      );

      // Build the user object from the API response
      _currentUser = User.fromJson(response['data']['user']['local'])
        ..id = response['data']['user']['_id']
      ;
    } on NetworkException catch(e, s) {
      Logger.e('Error authenticating user: ${e.message}', e: e, s: s);
      throw AuthException(e.message);
    } on AuthException catch(e, s) {
      Logger.e('AuthService: Error signing in', e: e, s: s);
      throw e;
    } catch(e, s) {
      Logger.e('Unknown Exception while authenticating', e: e, s: s);
      throw AuthException('Error signing in');
    }

    // Take the user to the home screen
    await _storage.saveIfAbsent(AppPreferenceKey.USER_SIGNED_IN, '');
    await _storage.saveString(AppPreferenceKey.USER_PHONE, phoneNumber);
    await _storage.saveString(AppPreferenceKey.USER_PASS, password);
    await _storage.saveString(AppPreferenceKey.USER_ID, currentUser.id);


    // _navigationService.clearStackAndShow(Routes.mainViewRoute, arguments: {'signup': false});
  }

  @override
  Future<void> signOut() async {
//    await Future.delayed(Duration(milliseconds: 250));
    _currentUser = null;
    _http.clearHeaders();
    await _storage.removeKey(AppPreferenceKey.USER_SIGNED_IN);
    await _storage.removeKey(AppPreferenceKey.USER_PHONE);
    await _storage.removeKey(AppPreferenceKey.USER_PASS);
    await _storage.removeKey(AppPreferenceKey.USER_ID);
    _logService.getValues(null, DateTime.now(), 'sign-out', '', false);
    _navigationService.clearStackAndShow(Routes.startupViewRoute);
  }

  @override
  Future<bool> get isUserLoggedIn async {
    // check server for login status
//    await Future.delayed(Duration(seconds: 1));

    return _currentUser != null;
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }
}
