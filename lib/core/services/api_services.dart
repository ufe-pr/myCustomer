import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/utils/logger.dart';

import './http/http_service_impl.dart';

abstract class IApi {
  /* CUSTOMER SERVICES */

  // to add a customer
  Future addCustomer(
      String name, String phoneNumber, String email, String lastName);

  // to get customers of a particular owner
  Future<Map> getCustomers();

  // to get a customer of a particular owner
  Future<Map> getCustomerbyId(String custId);

  // to update a customers details
  Future updateCustomerDetails(
    String customerId, {
    String name,
    String phoneNumber,
    String email,
    String lastName,
  });

  // to delete a customer
  Future deleteCustomer(String customerId);

  /* STORE SERVICES */

  Future newStore(
      String name,
      String address);

  Future updateStoreDetails(String storeId,
      String onwnerId,
      {String name,
      String address});

  Future<Map> getStore(String storeId);

  Future<Map> getAllStores();

  Future deleteStore(String storeId);

  /* USER/OWNER/ASSISTANT SERVICES */

  Future newAssistant(
      String name, String phoneNumber, String email, String password);

  Future updateOwnerDetails(String ownerId,
      {String name, String lastname, String email, String phoneNumber});

  Future updateAssistantDetails(String asstId,
      {String name, String email, String phoneNumber});

  Future<Map> getAssistant(String asstId);

  Future<Map> getAllAssistants();

  Future deleteAssistant(String asstId);

  /* TRANSACTION SERVICES */

  Future newTransaction(
      String type,
      double amount,
      double interest,
      double totalAmount,
      String description,
      String transactionName,
      String transactionRole,
      String phoneNumber,
      String storeName);

  Future updateTransaction(String transactionId,
      {String type,
      double amount,
      double interest,
      double totalAmount,
      String description,
      String transactionName,
      String transactionRole,
      String storeName});

  Future<Map> getTransactions();

  Future<Map> getTransaction(String trxId);

  Future deleteTransaction(String tranxId);

  /* NOTIFICATION SERVICES */

  Future callCustomer(String custId, String phoneNumber);

  Future remindWithSms(
      String custId, String message);

  Future remindWithEmail(
      String custId, String message, String subject, String storeId);

  /* AUTH SERVICES */

  Future<dynamic> registerUser(String name, String lastname, String phone,
      String password, String email);

  Future<dynamic> verify(String id, String token);

  Future<Map> verifyPhone(String phoneNumber);

  /* COMPLAINT SERVICES */

  Future newComplaint(
      String message, String name, String email, String ownerId);

  Future updateComplaint(String complaintId, String ownerId,
      {String message, String name, String email});

  Future<Map> allComplaints(String ownerId);

  Future deleteComplaint(String complaintId);
}

class ApiServices extends IApi {
  static const BASE_URL = 'https://dev.api.customerpay.me';

  HttpService _serviceImpl =  locator<HttpService>();

  @override
  Future addCustomer(
      String storeName, String name, String phoneNumber, String email) async {
    var body = {
      'name': name,
      'emmail': email,
      'phone_number': phoneNumber,
      'store_name': storeName
    };
    var customer = await _serviceImpl.postHttp('$BASE_URL/customer/new', body);
    Logger.d('$customer');
    return customer;
  }

  @override
  Future<Map> allComplaints(String ownerId) async {
    var data = await _serviceImpl.getHttp('$BASE_URL/complaints/$ownerId');
    return data;
  }

  @override
  Future callCustomer(String custId, String phoneNumber) {
    // TODO: implement callCustomer
    throw UnimplementedError();
  }

  @override
  Future deleteComplaint(String complaintId) {
    // TODO: implement deleteComplaint
    throw UnimplementedError();
  }

  @override
  Future deleteCustomer(String customerId) {
    // TODO: implement deleteCustomer
    throw UnimplementedError();
  }

  @override
  Future deleteStore(String storeId) {
    // TODO: implement deleteStore
    throw UnimplementedError();
  }

  @override
  Future deleteTransaction(String tranxId) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<Map> getAllStores() async {
    var stores = await _serviceImpl.getHttp('$BASE_URL/store');
    return stores;
  }

  @override
  Future<Map> getCustomerbyId(String custId) async {
    var customer = await _serviceImpl.getHttp('$BASE_URL/customer/$custId');
    Logger.d('$customer');
    return customer;
  }

  @override
  Future<Map> getCustomers() async {
    var data = await _serviceImpl.getHttp('$BASE_URL/customer');
    Logger.d('$data');
    return data;
  }

  @override
  Future<Map> getStore(String storeId) async {
    var store = await _serviceImpl.getHttp('$BASE_URL/store/$storeId');
    return store;
  }

  @override
  Future<Map> getTransactions() async {
    var trx = await _serviceImpl.getHttp('$BASE_URL/transaction');
    return trx;
  }

  @override
  Future<Map> newComplaint(
      String message, String name, String email, String ownerId) async {
    var body = {'name': name, 'email': email, 'message': message};
    var data =
        await _serviceImpl.postHttp('$BASE_URL/complaint/new/$ownerId', body);
    Logger.d('$data');
    return data;
  }

  @override
  Future newStore(
      String name,
      String address) async {
    var body = {
      'store_name': name,
      'shop_address': address
    };
    print('Got here');
    try {
    var store = await _serviceImpl.postHttp('$BASE_URL/store/new', body);
      Logger.d('$store');
      return store;
    } catch (e, s) {
      Logger.d('Exception: $e, Stacktrace: $s');
      rethrow;
    }
  }

  @override
  Future newTransaction(
      String type,
      double amount,
      double interest,
      double totalAmount,
      String description,
      String transactionName,
      String transactionRole,
      String phoneNumber,
      String storeName) async {

    var body = {
    'amount': amount,
    'interest': interest,
    'total_amount': totalAmount,
    'description': description,
    'phone_number': phoneNumber,
    'store_name': storeName,
    'type': type,
    'transaction_name': transactionName,
    'transaction_role': transactionRole,
    };
    var trx = await _serviceImpl.postHttp('$BASE_URL/transaction/new', body);
    Logger.d('$trx');
    return trx;
  }

  @override
  Future registerUser(String name, String lastname, String phone,
      String password, String email) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future remindWithEmail(
      String custId, String message, String subject, String storeId) async {
    var body = {
      'text': message,
      'subject': subject,
      'store_id': storeId
    };
    var res = await _serviceImpl.postHttp('$BASE_URL/reminder/email/$custId', body);
    Logger.d('$res');
    return res;
  }

  @override
  Future remindWithSms(
      String custId, String message) async {
     var res = await _serviceImpl.postHttp('$BASE_URL/reminder/sms/$custId', {'message': message});
     return res;
  }

  @override
  Future updateComplaint(String complaintId, ownerId,
      {String message, String name, String email}) async {
    var body = {
      'complaint_id': complaintId,
      message ?? 'message': message,
      name ?? 'name': name,
      email ?? 'email': email
    };
    var data = await _serviceImpl.putHttp(
        '$BASE_URL/complaints/update/$ownerId', body);
    return data;
  }

  @override
  Future updateCustomerDetails(String customerId,
      {String name, phoneNumber, String email, String lastName}) async {
    var body = {
      name ?? 'name': name,
      email ?? 'email': email,
      phoneNumber ?? 'phone_number': phoneNumber
    };
    var data = await _serviceImpl.putHttp(
        '$BASE_URL/customer/update/$customerId', body);
    return data;
  }

  @override
  Future updateOwnerDetails(String ownerId,
      {String name, String lastname, String email, String phoneNumber}) async {
    var body = {
      name ?? 'first_name': name,
      lastname ?? 'last_name': lastname,
      email ?? 'email': email,
      phoneNumber ?? 'phone_number': phoneNumber
    };
    var update =
        await _serviceImpl.putHttp('$BASE_URL/store-admin/update', body);
    Logger.d('$update');
    return update;
  }

  @override
  Future updateStoreDetails(String storeId,
      String ownerId,
      {String name,
      String address}) async {
    var body = {
      'current_user': ownerId,
      'store_name': name,
      'shop_address': address
    };
    var update = await _serviceImpl.putHttp('$BASE_URL/store/update/$storeId', body);
    Logger.d('$update');
    return update;
  }

  @override
  Future updateTransaction(String transactionId,
      {String type,
      double amount,
      double interest,
      double totalAmount,
      String description,
      String transactionName,
      String transactionRole,
      String storeName}) async {
    var body = {
    amount ?? 'amount': amount,
    interest ?? 'interest': interest,
    totalAmount ?? 'total_amount': totalAmount,
    description ?? 'description': description,
    storeName ?? 'store_name': storeName,
    type ?? 'type': type,
    transactionName ?? 'transaction_name': transactionName,
    transactionRole ?? 'transaction_role': transactionRole,
    };

    var trx = await _serviceImpl.postHttp('$BASE_URL/transaction/update/$transactionId', body);
    Logger.d('$trx');
    return trx;
  }

  @override
  Future verify(String id, String token) {
    // TODO: implement verify
    throw UnimplementedError();
  }

  @override
  Future<Map> verifyPhone(String phoneNumber) {
    // TODO: implement verifyPhone
    throw UnimplementedError();
  }

  @override
  Future deleteAssistant(String storeId) {
    // TODO: implement deleteAssistant
    throw UnimplementedError();
  }

  @override
  Future<Map> getAllAssistants() async {
    var data = await _serviceImpl.getHttp('$BASE_URL/assistant');
    Logger.d('$data');
    return data;
  }

  @override
  Future<Map> getAssistant(String asstId) async {
    var data = await _serviceImpl.getHttp('$BASE_URL/assistant/$asstId');
    Logger.d('$data');
    return data;
  }

  @override
  Future newAssistant(
      String name, String phoneNumber, String password, String email) async {
    var body = {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password
    };
    var data = await _serviceImpl.postHttp('$BASE_URL/assistant/new', body);
    Logger.d('$data');
    return data;
  }

  @override
  Future updateAssistantDetails(String asstId,
      {String name, String email, String phoneNumber}) async {
    var body = {'name': name, 'email': email, 'phone_number': phoneNumber};
    var update =
        await _serviceImpl.putHttp('$BASE_URL/assistant/update$asstId', body);
    Logger.d('$update');
    return update;
  }

  @override
  Future<Map> getTransaction(String trxId) async {
    var trx = await _serviceImpl.getHttp('$BASE_URL/transaction/$trxId');
    return trx;
  }
}
