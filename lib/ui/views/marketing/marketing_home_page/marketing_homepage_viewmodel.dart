import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';


class MarketingHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  // dummy data
  // TODO: implement service to get frequently contacted
  List _persons = [
    {'name': 'Seyi Onifade', 'number': '09088355273'},
    {'name': 'Mark Essien', 'number': '09088355273'},
    {'name': 'Ufe Atabo', 'number': '09088355273'}
  ];

  // TODO: implement service to get notification status
  bool _notification = true;

  bool get notification => _notification;

  List get persons => _persons;

  // Function to serve as a helper for the navigation
  Future navigateToSendMessageView() async {
    await _navigationService.navigateTo(Routes.quickMessages, arguments: _selectedCustomers);
//    await _navigationService.navigateTo(Routes.sendMessageViewRoute, arguments: _selectedCustomers);
  }

  // Get the services required
  ICustomerService _customerService = locator<ICustomerService>();

  List<Customer> allCustomers = [];

  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  List<Customer> _allSelectedCustomers = [];
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  List<Customer> get searchedCustomer => allCustomers.where(
        (Customer customer) =>
    customer.name.contains(searchPattern) ||
        customer.lastName.contains(searchPattern) ||
        customer.phone.contains(searchPattern)||
        customer.email.contains(searchPattern),
  ).toList();
  List<Customer> get allSelectedCustomers => _allSelectedCustomers.where(
        (Customer customer) =>
            customer.name.contains(searchPattern) ||
            customer.lastName.contains(searchPattern) ||
            customer.phone.contains(searchPattern) ||
            customer.email.contains(searchPattern),
      ).toList();


  /// Data checking section

  bool get hasData => _allSelectedCustomers.isNotEmpty;
  bool get hasSelected => _selectedCustomers.isNotEmpty;
  int get numberOfSelected => _selectedCustomers.length;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  bool get allSelected => _allSelectedCustomers.length == _selectedCustomers.length;

  TextEditingController searchController = TextEditingController();
  search(String keyword) {
    _searchTerm = keyword;
    notifyListeners();
  }

  void addCustomer(Customer customer) {
    _selectedCustomers.add(customer);
    notifyListeners();
  }

  void deselectCustomer(Customer customer) {
    _selectedCustomers.removeWhere((element) => element.phone == customer.phone);
    notifyListeners();
  }
  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
  }

  void selectAllCustomers() {
    _selectedCustomers.clear();
    _selectedCustomers.addAll(_allSelectedCustomers);
    notifyListeners();
  }

  void deselectAllCustomers() {
    _selectedCustomers = [];
    notifyListeners();
  }
  void removeCustomers(Customer customer) {
    allCustomers.removeWhere((element) => element.phone == customer.phone);
    _selectedCustomers.removeWhere((element) => element.phone == customer.phone);
    notifyListeners();
  }
//  void updateCustomers() async{
//    fianl customerList = await _navigationService
//  }

 PermissionService _permission =  locator<IPermissionService>();
  Future checkPermission() async {
    
     return await _permission.getContactsPermission(); 
  }
  Future requestPermission() async{
    return await [Permission.contacts].request();
  }
   Future navigateToAddCustomers(context) async{
     Navigator.of(context).pushNamed(Routes.addCustomerMarketing, arguments: _allFrequentCustomers).then((_){
       final arguments = ModalRoute.of(context).settings.arguments as Map;
       final result = arguments['result'];
     allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
     _allFrequentCustomers = allCustomers;
      notifyListeners();
     
     });
    notifyListeners();
  }
  Future navigateToAddNewCustomer(context) async{
    Navigator.of(context).pushNamed(Routes.addNewCustomerMarketing).then((_){
       final arguments = ModalRoute.of(context).settings.arguments as Map;
       final result = arguments['result'];
     allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
      notifyListeners();
     
     });
    notifyListeners();
  }

  Future navigateToSendMessage(context) async{
    // Navigator.of(context).pushNamed(Routes.sendMessageViewRoute,arguments: _selectedCustomers).then((_){
    //    final arguments = ModalRoute.of(context).settings.arguments as Map;
    //    final result = arguments['result'];
    //  allCustomers = result.length != 0?[...allCustomers,...result]:allCustomers;
    //   notifyListeners();
     
    //  });
    // notifyListeners();
  }


  

  Future navigateToAddCustomer() async {
    var contactList;
    final bool isPermitted =
        await _permission.getContactsPermission();

    if(!isPermitted){
      await [Permission.contacts].request();
    }else if(isPermitted){
      contactList = await _navigationService
        .navigateTo(Routes.addCustomerMarketing);
    }else{
      contactList = await  _navigationService
        .navigateTo(Routes.addNewCustomerMarketing);
    }
    // if (isPermitted) contactList = await _navigationService
    //     .navigateTo(Routes.addCustomerMarketing);
    // else contactList = await  _navigationService
    //     .navigateTo(Routes.addNewCustomerMarketing);
    // await contactList;
//    print(contactList);
//    final results = contactList['result'];
//    allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;
//    allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;



//    if(_selectedCustomers.length !=0 ){
//      _navigationService
//          .navigateTo(Routes.sendMessageViewRoute, arguments: _selectedCustomers);
//    }else{
//      if (isPermitted) contactList = await _navigationService
//          .navigateTo(Routes.addCustomerMarketing);
//      else contactList = await  _navigationService
//          .navigateTo(Routes.addNewCustomerMarketing);
//      await contactList;
//      allCustomers = contactList.length != 0?[...allCustomers,...contactList]:allCustomers;
//    }
//    if (isPermitted) contactList= await _navigationService
//        .navigateTo(Routes.addCustomerMarketing);
//    else await [Permission.contacts].request();
//    allCustomers
//     = await contactList.length != 0?contactList:allCustomers;
//    await contactList;
//    if(!contactList==null){allCustomers =  contactList;}

    notifyListeners();
  }


  void sendMessage(){
    

    _navigationService
        .navigateTo(Routes.quickMessages,arguments: _selectedCustomers);
//        .navigateTo(Routes.sendMessageViewRoute,arguments: _selectedCustomers);
  }

  /// View initialize and close section

  popView() {
    _navigationService.back();
  }

  returnCustomers() {
    _navigationService.back(result: _selectedCustomers);
  }

  @override
  Future futureToRun() async {
   _allSelectedCustomers = await _customerService.getCustomers('1');
  }
}
