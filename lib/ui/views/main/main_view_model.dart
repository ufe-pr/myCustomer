import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends ReactiveViewModel {
  /// Fields
  final NavigationService _navigationService = locator<NavigationService>();
//  static AuthService _auth = locator<AuthService>();
  final _logService = locator<LogsLocalDataSourceImpl>();
  final _bussinessService = locator<BussinessSettingService>();
  final ICustomerService _customerService = locator<ICustomerService>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  final _customerContactService = locator<CustomerContactService>();

  final Duration duration = const Duration(milliseconds: 500);
  List<Store> _stores = StoreRepository.stores;
  Map<String, int> _customers = {};

  int _index = 0;

  bool isCollapsed = true;

  /// Getters
  int get index => _index;

  List<Store> get stores => _stores;

  Map<String, int> get customers => _customers;

  Store get currStore => StoreRepository.currentStore;

  bool get showdot => _logService.shouldnotify;

  /// Setters

  /// Methods/Functions
  void addlog() {
    print('called1');
    _logService.testfunc(DateTime.now());
  }

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void updateMenu() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  void changeBusiness(String id) {
    StoreRepository.changeSelectedStore(id);
    _transactionService.getAllTransactions(id);
    notifyListeners();
//    updateMenu();
  }

  void getcurr() {
    _bussinessService.getCurrency();
    //_storeService.updateStores();
  }

  Future navigateToAddBusiness() async {
    _navigationService.navigateTo(Routes.createBusinessView);
  }

  Future<Map<String, int>> getCustomers() async {
    Map<String, int> customerMap = {};
    for (var store in _stores) {
      final customers = await _customerService.getCustomers(store.id);
      customerMap.putIfAbsent(store.id, () => customers.length);
    }
    _customers = customerMap;
  }

  int getCustomerCount(String id) {
    //print(_customerContactService.getCustomerCount(id).then((value) => print(value)));
    //int tot;
   return _customerContactService.getCustomerCount(id);
    //return tot;
  }

  void navigateToNotifications() {
    _navigationService.navigateTo(Routes.notificationsViewRoute);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logService, _bussinessService];
}
