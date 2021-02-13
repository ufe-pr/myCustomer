import 'package:hive/hive.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked_services/stacked_services.dart';

class AddCustomerManuallyViewModel extends ReactiveViewModel {
  String _customerName;
  String _customerPhoneNumber;
  NavigationService _nav = locator<NavigationService>();

  String _dropDownValue='+234';
PhoneNumber number = PhoneNumber(isoCode: isoCode);
  List<String> _countryCodes=['+234','+254','+250','+230'];

  String get customerName => _customerName;
  String get customerPhoneNumber => _customerPhoneNumber;

  

  List<String> get countryCode=>_countryCodes;
  String get dropDownValue=> _dropDownValue;
  bool success = false;
//  String error;
  //NavigationService _navigationService = locator<NavigationService>();

  String _title='Add Customer';
  String _subTitle='Customer Details';

  String get title => _title;
  String get subTitle =>_subTitle;

  final _customerContactService = locator<CustomerContactService>();

  navigateToImport() {
    _nav.replaceWith(Routes.importCustomerCreditorViewRoute);
  }

  void updateName(String name){
    _customerName=name;
    notifyListeners();
  }

  void updateContact(String phoneNumber){
    _customerPhoneNumber=phoneNumber;
    notifyListeners();

  }

  void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }

  void addContact(String action)async {
    print(customerPhoneNumber);
    if(customerName != null && customerPhoneNumber != null) {
      //_customerContactService.addContact(customerPhoneNumber, customerName, dropDownValue, customerName.split(' ').length > 1 ? (customerName.split(' ')[0][0]+customerName.split(' ')[1][0]).toUpperCase() : customerName.split(' ')[0][0].toUpperCase(), action);
    }
    notifyListeners();
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_customerContactService];
}