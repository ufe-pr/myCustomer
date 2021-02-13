//import 'dart:async';
//import 'dart:collection';
//import 'dart:io';
//
//import 'package:mycustomers/app/locator.dart';
//import 'package:mycustomers/app/router.dart';
//import 'package:stacked/stacked.dart';
//import 'package:stacked_services/stacked_services.dart';
//import 'package:flutter/material.dart';
////import 'package:url_launcher/url_launcher.dart';
//
//import 'package:contacts_service/contacts_service.dart';
//import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
//import 'package:mycustomers/core/services/customer_services.dart';
//import 'package:mycustomers/core/services/owner_services.dart';
//
//class SendMessageViewModel extends StreamViewModel {
//  final NavigationService _navigationService = locator<NavigationService>();
//  TextEditingController titleController =TextEditingController();
//  TextEditingController messageController =TextEditingController();
//
//
//  Future navigateToSendMessage() async {
////    await _navigationService.navigateTo(Routes.messageSntDialog,);
////  const uri = 'sms: +60000000000?body=message';
////  if(Platform.isAndroid){
////    if(await canLaunch(uri)){
////      await launch(uri);
////
////    }else{
////      print('no');
////    }
////    url ='sms: +60000000000?body=message';
////    await launch(uri);
////  }
////  else if(Platform.isIOS){
////    const url ='sms: +60000000000?body=message';
////    await launch(url);
////  }
//  }
//
//  Future returnHome() async {
//     _navigationService.popRepeated(3);
//  }
//
//  StreamController _contactStream = StreamController<List<Customer>>();
//  IOwnerServices iOwnerServices = locator<IOwnerServices>();
//  List<Customer> _allCustomers = List<Customer>();
//  bool _busy = true;
//  bool get isLoadBusy => _busy;
//  SendMessageViewModel();
//  Iterable<Contact> contacts;
//  List<Customer> _selectedCustomers = [];
//  List<Customer> get selectedCustomers => _selectedCustomers;
//  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
//  List<Customer> _allFrequentCustomers = [];
//  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
//  init({String query}) async {
////    _allCustomers.clear();
//    for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
//      print('Iterate');
//      if (_busy) {
//        _busy = false;
//        notifyListeners();
//      }
//      _allCustomers.add(customer);
//      _contactStream.add(_allCustomers);
//    }
//  }
//
//  String _searchTerm = '';
//  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);
//  void selectCustomer(Customer customer) {
//    _selectedCustomers.add(customer);
//    print(_selectedCustomers.length);
//    notifyListeners();
//  }
//  void mergeSelectCustomer(List<Customer> customers) {
//
//    final merge = [..._selectedCustomers,...customers];
//
//
////    if(_selectedCustomers.)
////    final unique =
//
////    final merge = [..._selectedCustomers,...customers];
////    _selectedCustomers =unique;
//    _selectedCustomers = merge.toSet().toList();
////    _selectedCustomers = [..._selectedCustomers,...customers];
//    print(_selectedCustomers.length);
//    notifyListeners();
//  }
//  void setCurrentText(String message){
//    print(message);
//
//  }
//
//  Future initSelected(List<Customer> customers){
//    _selectedCustomers = _selectedCustomers.length == 0?[..._selectedCustomers,...customers]
//        :_selectedCustomers;
//    notifyListeners();;
//
//  }
//
//  void getFrequentCustomers() {
//    //todo: get frequent customers
////    allFrequentCustomers
//  }
//
//  void deselectCustomer(Customer customer) {
//    print(customer.id);
//    _selectedCustomers.removeWhere((element) => element.phone == customer.phone);
//    notifyListeners();
//  }
////  //todo: implement add new customer
//  Future navigateToAddNewCustomer() async {
//
//    final newContact= await _navigationService
//        .navigateTo(Routes.addNewCustomerMarketing);
//
//    await newContact!= null??
//        _allCustomers.add(newContact);
//    selectedCustomers.add(newContact);
//    notifyListeners();
//    print(newContact.name);
//  }
//  /// View initialize and close section
//
//  popView() {
//    _navigationService.back();
//  }
//  returnCustomers() {
//    _navigationService.back(result: _selectedCustomers);
//
//  }
//
//
//
//  TextEditingController searchController = TextEditingController();
//  search(String keyword) async {
//    _searchTerm = keyword;
//    _busy = true;
//    notifyListeners();
//    init(query: _searchTerm);
//  }
//  Future navigateToQuickMessage(selected) async {
//    await _navigationService.navigateTo(Routes.quickMessages, arguments: selected);
//  }
//  Future navigateToMessage(selected) async {
//    await _navigationService.navigateTo(Routes.messageView, arguments: selected);
//  }
//
//  @override
//  Stream get stream => _contactStream.stream;
//}

class MessageArgument{
  String title,message;
  List<Customer> selectedCustomers;


  MessageArgument({this.title, this.message, this.selectedCustomers});

}