import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ImportCustomerViewModel extends StreamViewModel {
  // Get the services required
  NavigationService _navigationService = locator<NavigationService>();

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  final _customerContactService = locator<CustomerContactService>();
  List<Customer> _contactsList = List<Customer>();
  bool _busy = true;

  bool get isLoadBusy => _busy;

  ImportCustomerViewModel();


  init({String query}) async {
    _contactsList.clear();
    for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
      print('Iterate');
      if (_busy) {
        _busy = false;
        notifyListeners();
      }
      _contactsList.add(customer);
    _contactStream.add(_contactsList);
    }
  }

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  TextEditingController searchController = TextEditingController();
  search(String keyword) async {
    _searchTerm = keyword;
    _busy = true;
    notifyListeners();
    init(query: _searchTerm);
  }

  void addContact(String name, String phone, String initials, String action){
    print(initials);
    //_customerContactService.addContact(phone, name, '', initials, action);
  }

  /// View initialize and close section
  popView() {
    _navigationService.back();
  }

  goToManual(String action) {
    _navigationService.navigateTo(action == 'debtor' ? Routes.addCustomerManuallyDebtor : Routes.addCustomerManuallyCreditor);
  }


  @override
  Stream get stream => _contactStream.stream;

}