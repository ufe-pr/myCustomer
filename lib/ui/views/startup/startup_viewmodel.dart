import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final IStorageUtil _storage = locator<IStorageUtil>();
  final AuthService _auth = locator<AuthService>();
  final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();

  bool previewImport = false;

  get currentStore => StoreRepository.currentStore;

  Future setup() async {
    await locator.allReady();
//    await  Future.delayed(Duration(seconds: 1));
    if (await checkLoggedIn()) {
      if (confirmHasStore()) {
        _navigationService.replaceWith(Routes.mainViewRoute);
        _logService.getValues(null, DateTime.now(), 'sign-in', '', false);
      }
    }
    else
      _navigationService.replaceWith(Routes.onboardingViewRoute);
  }

  bool confirmHasStore() {
    print('Current store is $currentStore');
    if (currentStore == null) {
      _navigationService.replaceWith(Routes.createBusinessView);
      return false;
    }
    return true;
  }

  Future<String> getEncryptionKey() async {
    return await Future.delayed(
      Duration(seconds: 1),
      () => Future.value('1890'),
    );
  }

  Future<Map<String, String>> getDecryptedDetails(String key) async {
    return await Future.delayed(
      Duration(seconds: 1),
      () => Future.value({
        'phone_number': _storage.getString(AppPreferenceKey.USER_PHONE),
        'password': _storage.getString(AppPreferenceKey.USER_PASS),
        'id': _storage.getString(AppPreferenceKey.USER_ID),
        'first_name': _storage.getString(AppPreferenceKey.USER_FULL_NAME),
        'email': _storage.getString(AppPreferenceKey.USER_EMAIL),
      }),
    );
  }

  Future<bool> checkLoggedIn() async {
    bool hasLoggedIn =
        _storage.getString(AppPreferenceKey.USER_SIGNED_IN) != null;
    Logger.d('User has${hasLoggedIn ? '' : 'not '} logged in');
    if (!hasLoggedIn) return false;
    var key = await getEncryptionKey();
    if (key == null) return false;
    try {
      Map deets = await getDecryptedDetails(key);
      if (deets == null) throw AuthException('Incorrect password');
      _auth.updateCurrentUser(User(
        id: deets['id'] ?? 'dvdykdsd9784-mkl-8hnf',
        phoneNumber: deets['phone_number'],
        firstName: deets['first_name'],
        email: deets['email'],
      ));
      print(_auth.currentUser.phoneNumber);
      await StoreRepository.updateStores();
      // await _auth.signInWithPhoneNumber(deets['phone_number'], deets['password']);
      return true;
    } on AuthException catch (e, s) {
      Logger.e(e.message, e: e, s: s);
    } catch (e, s) {
      Logger.e('Unknown error', e: e, s: s);
    }

    return false;
  }
}
