import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

abstract class CustomerContactDataSource{
  Future<void> init();
}

@lazySingleton
class CustomerContactService extends CustomerContactDataSource with ReactiveServiceMixin {
  //static const String _boxname = "contactBox";
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.contact);
  Box<CustomerContact> get _contactBox => _hiveService.box<CustomerContact>(HiveBox.contact);
  
  RxValue<List<CustomerContact>> _contacts = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get contacts => _contacts.value;
  bool success, error;

  NavigationService _navigationService = locator<NavigationService>();
  //var box = Hive.openBox<CustomerContact>(_boxname);

  RxValue<CustomerContact> _contact = RxValue<CustomerContact> (initial: null);
  CustomerContact get contact => _contact.value;

  final _transactionService = locator<TransactionLocalDataSourceImpl>();

  var uuid = Uuid();

  CustomerContactService(){
    listenToReactiveValues([_contacts, _contact]);
  }

  @override
  Future<void> init() async {
    _hiveService.registerAdapter(CustomerContactAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<CustomerContact>(HiveBox.contact);
    }
  }

  void getContacts() async {
    //final bbox = await box;
    _contacts.value = _contactBox.values.toList();
    _contacts.value.sort((a,b) => b.id.compareTo(a.id));
  }

  int getCustomerCount(String stid) {
    int sum = 0;
    for(var item in _contacts.value) {
      if(item.storeid == stid) {
        sum+=1;
      }
    }
    //print(sum == null ? 0 : sum);
    return sum;
  }

  void setContact(CustomerContact cont){
    _contact.value = cont;
    print(cont.id);
    _navigationService.navigateTo(Routes.mainTransaction);
  }

  void addContact(String customerPhoneNumber, String customerName, String dropDownValue, String initials, String action, TransactionModel transaction, String stid)async {
    print(customerPhoneNumber);
    print(customerName);
    print(dropDownValue);
    if(customerName != null && customerPhoneNumber != null) {
      print('sent');
      //final bbox = await box;
      bool isStored = false;
      for(var item in _contactBox.values.toList()){
        if(item.name == customerName && item.phoneNumber == customerPhoneNumber){
          _contact.value = CustomerContact(name: item.name, phoneNumber: item.phoneNumber, id: item.id, initials: item.initials, storeid: item.storeid);
          isStored = true;
        }
      }
      if(isStored){
        TransactionModel ntransaction = new TransactionModel(
            cId: contact.id,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
        _transactionService.addTransaction(ntransaction);
          _navigationService.navigateTo(Routes.mainViewRoute);
        //_navigationService.navigateTo(Routes.mainTransaction);
      } else {
        CustomerContact contact = new CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: uuid.v4(), initials: initials, storeid: stid);
        _contactBox.add(contact).then((value){
          success = true;
          print(success);
          _contact.value = CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: uuid.v4(), initials: initials, storeid: stid);
          print('set ${contact.id}');
          _contacts.value = _contactBox.values.toList();
          TransactionModel ntransaction = new TransactionModel(
            cId: contact.id,
            sId: transaction.sId,
            amount: transaction.amount,
            paid: transaction.paid,
            description: transaction.description,
            duedate: transaction.duedate,
            boughtdate: transaction.boughtdate,
            paiddate: transaction.paiddate
          );
          _transactionService.addTransaction(ntransaction);
          _navigationService.navigateTo(Routes.mainViewRoute);
          //_contacts.value.sort((a,b) => b.id.compareTo(a.id));
          //action == 'debtor' ? _navigationService.navigateTo(Routes.addDebt) : _navigationService.navigateTo(Routes.addCredit);
        }).catchError((err){
          error = err;
          print(error);
          print('Failed To save Contact');
          success = false;
        });
        print(_contactBox.values.toList());
      }
      
    }
  }

}