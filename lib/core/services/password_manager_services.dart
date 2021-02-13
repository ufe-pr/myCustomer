
import 'package:encrypt/encrypt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycustomers/core/utils/user_settings_prefs.dart';

class PasswordManagerService{
  
    static final  key = Key.fromLength(32);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    bool _isPinSet=false;
    bool get isPinSet => _isPinSet;
    SharedPreferencesHelper object=new SharedPreferencesHelper();



  Future<void>saveSetPin(String password) async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    final encryptedPassword = encryptPassword(password);
    object.saveUserPin(encryptedPassword, prefs);
 }
   
   void setPin(bool value){
     _isPinSet= value;
   }


  //This function display a success message upon completion of setting pin
  void showPinSetConfirmationMessage(){
    FlutterToast.showToast(
      msg: 'Pin was set Successfully',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.yellow,
      textColor: ThemeColors.black,
      gravity: ToastGravity.CENTER

      );
  }

  


  void showErrorMessage(){
    FlutterToast.showToast(
      msg: 'An error occured while setting pin',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.secondary,
      textColor: ThemeColors.background,
      gravity: ToastGravity.CENTER
      );
  }

  void showRemoveErrorMessage(){
    FlutterToast.showToast(
      msg: 'Wrong pin ! Try again.',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.secondary,
      textColor: ThemeColors.background,
      gravity: ToastGravity.CENTER
      );
  }

  void showUnmatchedPinErrorMessage(){
    FlutterToast.showToast(
      msg: 'Pins don\'t match! Try again.',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.secondary,
      textColor: ThemeColors.background,
      gravity: ToastGravity.CENTER
      );
  }





  String encryptPassword(String value){

    return encrypter.encrypt(value, iv: iv).base64;
     }


  String decryptPassword(String value){
    final newValue = Encrypted.from64(value);
    return encrypter.decrypt(newValue, iv: iv);
    
}

  Future<String> getPassword() async{
      SharedPreferences prefs = await  SharedPreferences.getInstance();
      final pass = await object.getUserPin(prefs);
      final decryptedPass = decryptPassword(pass);
      print(decryptedPass);
      return decryptedPass ;
}

Future<void> deleteSetPin() async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    object.removeUserPin(prefs);

}
}