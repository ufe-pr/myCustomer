import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/app_preference_keys.dart';
import 'package:mycustomers/core/mixins/validators.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/storage_util_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/core/data_sources/stores/stores_remote_data_source.dart';
import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/exceptions/update_exception.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

class BusinessViewModel extends BaseViewModel with Validators {
  final NavigationService _navigationService = locator<NavigationService>();
  final StoresLocalDataSource _storeService = locator<StoresLocalDataSource>();
  final DialogService _dialogService = locator<DialogService>();
  final IStorageUtil _storage = locator<IStorageUtil>();
  final AuthService _auth = locator<AuthService>();

  Future<void> navigateToNext() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true,
        transition: 'cupertino',
        duration: Duration(milliseconds: 400));
  }

  Future<void> updateUser(String storeName, String shopAddress) async {
    bool busy = true;
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(
        title: 'Please hold on while we create your new store account');
    try {
      // await _userService.createAssistant(name);
      await _storeService.createStore(Store.fromJson({'store_name': storeName, 'shop_address': '$shopAddress'}));
      // Logger.e('message', e: CreateException('Completed store create'));
      // await _navigationService.clearStackAndShow(Routes.startupViewRoute);
      _dialogService.completeDialog(DialogResponse());
      showToastCustom(
        message: 'Your store has been created successfully',
        success: true,
      );

      busy = false;
      unawaited(navigateToNext());
    } on UpdateException catch (e, s) {
      showToastCustom(
        message: e.message,
      );
      Logger.e(e.message, e: e, s: s);
    } on CreateException catch (e, s) {
      showToastCustom(
        message: e.message,
      );
      Logger.e(e.message, e: e, s: s);
    } catch (e, s) {
      Logger.e('Unknown Error\nException: $e\nStacktrace: $s', e: e, s: s);
      showToastCustom(
        message: 'An error occured while creating your store account',
      );
    }
    if (busy) _dialogService.completeDialog(DialogResponse());
  }

  bool btnColor = true;

  void activeBtn() {
    btnColor = !btnColor;
    notifyListeners();
  }

  Future<void> updateUserDeets(String fullname, String email) async {
    await _storage.saveString(AppPreferenceKey.USER_FULL_NAME, fullname);
    await _storage.saveString(AppPreferenceKey.USER_EMAIL, email);
    _auth.updateCurrentUser(_auth.currentUser
    ..email = email
    ..firstName = fullname
    );
  }
}
