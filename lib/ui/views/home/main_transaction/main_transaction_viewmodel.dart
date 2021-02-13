import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainTransactionViewModel extends ReactiveViewModel{
  List purchases = [
    { 'id': 1, 'status': 'bought', 'amount': 50000, 'date': '2020-06-10 09:00:00' },
    { 'id': 2, 'status': 'paid', 'amount': 20000, 'date': '2020-06-10 11:00:00.00' },
    { 'id': 3, 'status': 'paid', 'amount': 20000, 'date': '2020-06-15 12:00:00.00' },
    { 'id': 4, 'status': 'paid', 'amount': 10000, 'date': '2020-06-15 10:00:00.00' },
    { 'id': 5, 'status': 'bought', 'amount': 80000, 'date': '2020-06-15 09:00:00.00' },
    { 'id': 6, 'status': 'paid', 'amount': 30000, 'date': '2020-06-20 11:00:00.00' },
    { 'id': 7, 'status': 'bought', 'amount': 60000, 'date': '2020-06-20 09:00:00.00' },
    { 'id': 8, 'status': 'paid', 'amount': 10000, 'date': '2020-06-25 13:00:00.00' },
  ];
  
  List<String> items = ['SMS', 'Call', 'Set Reminders'];
  String date;
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  List<TransactionModel> get transactions => _transactionService.transactions;
  List<TransactionModel> get debitlist => _transactionService.debitlist;
  List<TransactionModel> get creditlist => _transactionService.creditlist;

  final NavigationService _navigationService = locator<NavigationService>();
  
  final _customerContactService = locator<CustomerContactService>();
  CustomerContact get contact => _customerContactService.contact;

  final _bussinessService = locator<BussinessSettingService>();
  CountryCurrency get currency => _bussinessService.curren;

  Store get currentStore => StoreRepository.currentStore;

  List<String> get formattedate =>  List<String>.from(_transactionService.formattedate.reversed); //'10 Jun', '15 Jun', '20 Jun', '25 Jun'

  int bought(){
    int sum = 0;
    for (var item in transactions) {
      if(item.amount != 0) {
        sum += item.amount.round();
      }
    }
    return sum;
  }

  int paid(){
    int sum = 0;
    for (var item in transactions) {
      if(item.paid != 0) {
        sum += item.paid.round();
      }
    }
    return sum;
  }

  bool check(String gdate) {
    final dformat = new DateFormat('d MMM');
    return dformat.format(DateTime.parse(gdate)).toString() == date;
  }

  String getDate(String gdate) {
    final dformat = new DateFormat('d MMM');
    if(dformat.format(DateTime.parse(gdate)).toString() != date) {
      date = dformat.format(DateTime.parse(gdate)).toString();
    }
    return dformat.format(DateTime.parse(gdate)).toString();
  }

  String getTime(String gdate) {
    final dformat = new DateFormat('jm');
    return dformat.format(DateTime.parse(gdate)).toString();
  }

  void getTransactions(){
    print(contact.id);
    _transactionService.getTransactions(contact.id, currentStore.id);
    notifyListeners();
  }

  // void setDates() {
  //   print('dates');
  //   for(int i=0; i<transactions.length; i++) {
  //     print(transactions[i]);
  //     formattedate.add(getDate(transactions[i].date));
  //   }
  // }

  void navigateToHome(){
    _navigationService.replaceWith(Routes.mainViewRoute);
  }

void navigateToSchedule(){
    _navigationService.replaceWith(Routes.sendReminder);
  }
  void navigateDetails(TransactionModel item){
    _transactionService.setTransaction(item);
    _navigationService.navigateTo(Routes.transactionDetails);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService, _customerContactService, _bussinessService];
}