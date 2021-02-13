import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/exceptions/update_exception.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

class CreateBusinessViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StoresLocalDataSource _storeService = locator<StoresLocalDataSource>();
  final DialogService _dialogService = locator<DialogService>();
  final LogsLocalDataSourceImpl _logService =
      locator<LogsLocalDataSourceImpl>();

  String storeAddress = '';
  String storeName = '';

  Future<void> navigateToNext() async {
    await _navigationService.replaceWithTransition(
      MainView(),
      opaque: true,
      transition: 'cupertino',
      duration: Duration(milliseconds: 300),
    );
  }

  Future<void> updateUser() async {
    bool busy = true;
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(
        title: 'Please hold on while we create your new store account');
    try {
      await _storeService.createStore(
        Store.fromJson(
          {'store_name': storeName, 'shop_address': storeAddress},
        ),
      );

      _dialogService.completeDialog(DialogResponse());
      showToastCustom(
        message: 'Your store has been created successfully',
        success: true,
      );
      _logService.getValues(
          null, DateTime.now(), 'create-store', storeName, false);

      await Future.delayed(Duration(milliseconds: 200));
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
      Logger.e('Unknown Error, exception: $e stacktrace: $s', e: e, s: s);
      showToastCustom(
        message: 'An error occured while creating your store account',
      );
    }
    if (busy) _dialogService.completeDialog(DialogResponse());
  }

  void updateStoreAddress(String value) {
    storeAddress = value;
  }

  void updateStoreName(String value) {
    storeName = value;
  }
}
