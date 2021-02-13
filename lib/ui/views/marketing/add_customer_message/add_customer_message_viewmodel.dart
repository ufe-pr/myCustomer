import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


import 'dart:async';
import 'package:mycustomers/core/services/customer_contact_service.dart';

class AddCustomerMessageViewModel extends StreamViewModel {
  // Get the services required
  NavigationService _navigationService = locator<NavigationService>();
  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  List<Customer> _allCustomers = List<Customer>();
  bool _busy = true;
  bool get isLoadBusy => _busy;
  AddCustomerMessageViewModel();
  Iterable<Contact> contacts;
  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  init({String query}) async {
    _allCustomers.clear();
    for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
      print('Iterate');
      if (_busy) {
        _busy = false;
        notifyListeners();
      }
      _allCustomers.add(customer);
      _contactStream.add(_allCustomers);
    }
  }

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);
  void selectCustomer(Customer customer) {
    _selectedCustomers.add(customer);
    print(customer.displayName);
    notifyListeners();
  }

  void getFrequentCustomers(value) {
    //todo: get frequent customers
    _allFrequentCustomers = value !=null? value:[];
    notifyListeners();
  }

  void deselectCustomer(Customer customer) {
    print(customer.id);
    _selectedCustomers.removeWhere((element) => element.phone == customer.phone);
    notifyListeners();
  }
//  //todo: implement add new customer
  Future navigateToAddNewCustomer() async {

    final newContact= await _navigationService
        .navigateTo(Routes.addNewCustomerMarketing);

   await newContact!= null??
       _allCustomers.add(newContact);
   selectedCustomers.add(newContact);
    notifyListeners();
    print(newContact.name);
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



  TextEditingController searchController = TextEditingController();
  search(String keyword) async {
    _searchTerm = keyword;
    _busy = true;
    notifyListeners();
    init(query: _searchTerm);
  }


  @override
  Stream get stream => _contactStream.stream;

}
