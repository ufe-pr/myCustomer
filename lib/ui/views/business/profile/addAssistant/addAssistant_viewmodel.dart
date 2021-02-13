import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAssistantViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
String _title='Add New Assistant';
String get title => _title;

String _subTitle='Add a new assitant from your contact list.';
String get subTitle => _subTitle;

String _frmContact='Add from Contact List';
String get frmContact => _frmContact;

String _addManually='or quickly add a new contact';
String get addManually => _addManually;

String _nameLabel ='Name';
String _roleLabel='Role';
String _phoneNumberLabel='Phone Number';

String get nameLabel => _nameLabel;
String get roleLabel => _roleLabel;
String get phoneNumberLabel => _phoneNumberLabel;

String _nameHintText='Enter Name';
String _roleHintText='Enter Role';
String _phoneNumberHintText='Enter Phone Number';

String get nameHintText => _nameHintText;
String get roleHintText => _roleHintText;
String get phoneNumberHintText => _phoneNumberHintText;

String _btnText='Save';
String get btnText=> _btnText;


final textStyle = new TextStyle(
  fontSize:20.sp,
  letterSpacing: 0.270833,
  color: ThemeColors.gray.shade800
);

final formTextStyle= new TextStyle(
  fontSize: 20.sp,
  color:Color(0xff595959),

);

final hinttextStyle =new TextStyle(
  fontSize: 16.sp,
  color:Color(0xffd9d9d9)
);



validateFields(value) => value.isEmpty ? 'Please fill' : null;


void navigateBack() {
  _navigationService.back();
  }

}