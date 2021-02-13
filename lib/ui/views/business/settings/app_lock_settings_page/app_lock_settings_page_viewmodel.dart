import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLockSettingsPageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final PasswordManagerService _passwordManagerService = locator<PasswordManagerService>();

  bool _value;
  bool get value=>_value;


   bool getThecurrentStateOfPin(){

    setPin(_passwordManagerService.isPinSet);
    return value;
   
  }

  void setPin(bool value){
    _value = value;
    notifyListeners();

  }

  Future navigateToSetPinPage()async {
    await _navigationService.navigateTo(Routes.setPinSettingsViewRoute);
    notifyListeners();
  }

  Future navigateToChangePinPage() async {
    await _navigationService.navigateTo(Routes.changePinSettingsViewRoute);
     notifyListeners();
  }

  Future navigateToRemovePinPage() async {
    await _navigationService.navigateTo(Routes.removePinSettingsViewRoute);
    notifyListeners();
   

  }

}
