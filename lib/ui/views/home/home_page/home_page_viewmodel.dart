import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/ui/widgets/main/create_business/create_business_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';



class HomePageViewModel extends ReactiveViewModel {
  String _title = 'Home View';
  String get title => _title;
  String name = 'Seyi Onifade';
  String expectedTime = 'Expected a week ago';
  int amountOwing= 500;
//  String deadLineStatus = 'Not Paid';



  final double _amount = 100.86;
  double get amount => _amount;

  void btnViewDetails() {
    print('hello');
  }

  final NavigationService _navigationService = locator<NavigationService>();
  final _customerContactService = locator<CustomerContactService>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  

  PermissionService _permission =  locator<IPermissionService>();
  List<CustomerContact> get contacts => _customerContactService.contacts;
  List<TransactionModel> get transactions => _transactionService.alltransactions;
  double get whatyouowe  => _transactionService.whatyouowe;
  int tabNo = 0;
  List<TransactionModel> get owingcustomers => _transactionService.owingcustomers;
  List<TransactionModel> get owedcustomers => _transactionService.owedcustomers;
  final _bussinessService = locator<BussinessSettingService>();
  CountryCurrency get currency => _bussinessService.curren;
  String sName;
  String sDName;
  String sCName;
  bool contains;
  bool containsD;
  bool containsC;
  Store get currentStore => StoreRepository.currentStore;

  // Future navigateToAddCustomer() async {
  //   final bool isPermitted =
  //       await _permission.getContactsPermission();
  //   if (isPermitted) _navigationService.navigateTo(Routes.importCustomerViewRoute);
  //   else _navigationService.navigateTo(Routes.addCustomerManually);
  // }

  void getTransactions() {
    _transactionService.getAllTransactions(currentStore?.id ?? 'ghjkl3-.dj');
    notifyListeners();
  }

  void searchName(String value){
    sName = value;
    contains = false;
    for(var item in contacts){
      if(item.name.toLowerCase().contains(sName.toLowerCase())){
        contains = true;
      }
    }
    notifyListeners();
  }

  void searchDName(String value){
    sDName = value;
    containsD = false;
    for(var cus in owingcustomers){
      for(var item in contacts){
        if(cus.cId == item.id){
          if(item.name.toLowerCase().contains(sDName.toLowerCase())){
            containsD = true;
          }
        }
      }
    }
    notifyListeners();
  }

  void searchCName(String value){
    sCName = value;
    containsC = false;
    for(var cus in owedcustomers){
      for(var item in contacts){
        if(cus.cId == item.id){
          if(item.name.toLowerCase().contains(sCName.toLowerCase())){
            containsC = true;
          }
        }
      }
    }
    notifyListeners();
  }

  double bought(){
    double sum = 0;
    for (var item in transactions) {
      if(item.amount > item.paid) {
        sum += item.amount;
      }
    }
    return sum;
  }

  double paid(){
    double sum = 0;
    for (var item in transactions) {
      if(item.paid != 0) {
        sum += item.paid;
      }
    }
    return sum;
  }

  void changeTab(int val){
    tabNo = val;
    notifyListeners();
  }

  void getContacts() {
    _customerContactService.getContacts();
  }

  void setContact(String id, String name, String phone, String initials) {
    print(id);
    CustomerContact cus = new CustomerContact(id: id, name: name, phoneNumber: phone, initials: initials);
    _customerContactService.setContact(cus);
  }

  TextEditingController debtorsController = TextEditingController();
  void searchDebtors(value){
    notifyListeners();
    //todo: implement debtors search
  }
  TextEditingController creditorsController = TextEditingController();
  void searchCreditors(value){
    notifyListeners();
    //todo: implement creditors search
  }
  TextEditingController allCustomersController = TextEditingController();
  void searchAllCustomers(value){
    notifyListeners();
    //todo: implement allCustomers search
  }

  void navigateToDebt(){
    _navigationService.navigateTo(Routes.addnewDebt);
  }

  void navigateToCredit(){
    _navigationService.navigateTo(Routes.addnewCredit);
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_customerContactService, _transactionService, _bussinessService];
}

