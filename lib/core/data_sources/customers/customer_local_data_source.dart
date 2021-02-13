import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/models/hive/customer/customer_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/utils/logger.dart';

abstract class CustomersLocalDataSource {
  Future<void> init();
  Future<void> addCustomer(Customer customer);
  Future<Customer> getCustomer(String customerId);
  Future<void> updateCustomerDetails(String customerId, {int countryCode, String phoneNumber, 
        String name, String storeId, String email});
  Future<void> deleteCustomer(String customerId);
  Future<Iterable<Customer>> getStoresWhere(Function(CustomerH customerH) test);
}

class CustomersLocalDataSourceImpl implements CustomersLocalDataSource {

  var box = Hive.box<CustomerH>('customerBox');

  String get _currentStoreId => StoreRepository.currentStore.id;

  List<CustomerH> getAllCustomers() => box.values.toList();
  

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
  }

  List<int> splitPhone(String phone) {
    var pNum = phone.substring(phone.length - 10);
    var ctyCode = phone.substring(0, phone.length - 10);
    try {
      return [int.parse(pNum), int.parse(ctyCode)];
    } catch (e) {
      return [null, null];
    }
  }

  @override
  Future<void> addCustomer(Customer customer) async {

    int countryCode = splitPhone(customer.phone)[0];
    int pNum = splitPhone(customer.phone)[0];
    
    int add = await box.add(
      CustomerH(
        customer.id, 
        _currentStoreId,
        '${customer.name} ${customer.lastName}',
        pNum,
        countryCode,
        customer.email
      )
    );
    Logger.d(add);
  }

  @override
  Future<Customer> getCustomer(String customerId) async{

    Iterable<CustomerH> customers = box.values;
    try {

      CustomerH customer = customers.singleWhere((element) => element.id == customerId);
      return Customer.fromCustomerH(customer);

    } catch (e) {
      throw Exception('Not found');
    }
    
  }

  @override
  Future<void> updateCustomerDetails(String customerId, {int countryCode, String phoneNumber, 
        String name, String storeId, String email}) async{
    
    List<CustomerH> customers = box.values.toList();
  
    int index = customers.indexWhere((element) => element.id == customerId);

    CustomerH oldCust = customers[index];
    int ctyCode = splitPhone(phoneNumber)[0];
    int pNum = splitPhone(phoneNumber)[0];

    if(index != -1){
        CustomerH customerH = CustomerH(
        customerId, 
        storeId ?? oldCust.storeIdFor, 
        name ?? oldCust.name, 
        pNum ?? oldCust.pNum, 
        ctyCode ?? oldCust.ctyCode, 
        email ?? oldCust.email
      );
      return box.putAt(index, customerH);
    }
    throw Exception('Not found');
    
  }

  @override
  Future<void> deleteCustomer(String customerId) async {

    List<CustomerH> customers = box.values.toList();
    try {

      int index = customers.indexWhere((element) => element.id == customerId);
      return box.deleteAt(index);

    } catch (e) {
      throw Exception('$e');
    }
    
  }

  @override
  Future<Iterable<Customer>> getStoresWhere(Function(CustomerH customerH) test) async {
    return box.values.where(test).map((customerH) => Customer.fromCustomerH(customerH));
  }
  
}
