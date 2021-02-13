import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import 'package:mycustomers/core/services/permission_service.dart';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';

class MessageViewModel extends StreamViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController titleController =TextEditingController();
  TextEditingController messageController =TextEditingController();


  // Future navigateToSendMessage() async {
//    await _navigationService.navigateTo(Routes.messageSntDialog,);
//  const uri = 'sms: +60000000000?body=message';
//  if(Platform.isAndroid){
//    if(await canLaunch(uri)){
//      await launch(uri);
//
//    }else{
//      print('no');
//    }
//    url ='sms: +60000000000?body=message';
//    await launch(uri);
//  }
//  else if(Platform.isIOS){
//    const url ='sms: +60000000000?body=message';
//    await launch(url);
//  }
  // }

  PermissionService _permission =  locator<IPermissionService>();
  Future<bool> checkPermission() async {
     return await _permission.getContactsPermission(); 
  }
  Future requestPermission() async{
    return await [Permission.contacts].request();
  }

  Future returnHome() async {
     _navigationService.popUntil((route){
       if(route.settings.name == '/main'){
        (route.settings.arguments as Map)['result'] = _selectedCustomers;
         return true;
       }else{
         return false;
       }
     });
  }

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  List<Customer> _allCustomers = List<Customer>();
  bool _busy = true;
  bool get isLoadBusy => _busy;
  MessageViewModel();
  Iterable<Contact> contacts;
  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  init({String query}) async {
//    _allCustomers.clear();
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
    print(_selectedCustomers.length);
    notifyListeners();
  }
  void mergeSelectCustomer(List<Customer> customers) {

    final merge = [..._selectedCustomers,...customers];


//    if(_selectedCustomers.)
//    final unique =

//    final merge = [..._selectedCustomers,...customers];
//    _selectedCustomers =unique;
    _selectedCustomers = merge.toSet().toList();
//    _selectedCustomers = [..._selectedCustomers,...customers];
    print(_selectedCustomers.length);
    notifyListeners();
  }

  Future initSelected(List<Customer> customers){
    _selectedCustomers = _selectedCustomers.length == 0?[..._selectedCustomers,...customers]
        :_selectedCustomers;
    notifyListeners();

  }

  void setQuickText(title, message){
    if(title.length !=0){
      titleController.text= title;
      messageController.text = message;
    }
    
  }
  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
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
