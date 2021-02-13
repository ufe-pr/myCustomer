import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SetPinSettingsViewModel extends BaseViewModel {

 final PasswordManagerService _passwordManagerService =
      locator<PasswordManagerService>();
  final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();
  
   
  int _pin = 0;
  int _index = 0;
  

  int get index => _index;

  final NavigationService _navigationService = locator<NavigationService>();


  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void onCreatePinCompleted(String value) {
    _pin = int.parse(value);
    changeTab(1);
  }

  void onConfirmPinCompleted(String value,TextEditingController editingControllerText) async{
    int confirmPin = int.parse(value);
    int check = _pin.compareTo(confirmPin);
    String newValue = confirmPin.toString();
    if (check == 0) {
    await  _passwordManagerService.saveSetPin(newValue);
      setPin(true);
      _passwordManagerService.showPinSetConfirmationMessage();
      _navigationService.popRepeated(1);
    } 
    else if (check < 0 || check > 0){
          _passwordManagerService.showUnmatchedPinErrorMessage();
          clearValueIfPinsDoNotMatch(editingControllerText);
    }
    else {
      _passwordManagerService.showErrorMessage();
    }
  }

void setPin(bool value){
    _passwordManagerService.setPin(value);
    _logService.getValues(null, DateTime.now(), 'set-pin', '', false);
     notifyListeners();
   }

 void clearValueIfPinsDoNotMatch(TextEditingController textEditingController){
   for(int i =0; i < 4; i++){
      textEditingController.text = textEditingController.text.substring(0,textEditingController.text.length-1);
   }
   
    }

}