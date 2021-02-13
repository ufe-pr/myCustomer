import 'dart:math';

import 'package:mycustomers/core/models/customer.dart';

abstract class ICustomerService {
  // to add a customer
  Future<void> addCustomer({
    String name,
    String phoneNumber,
    String email,
    String lastName,
  });

  // to get customers of a particular owner
  Future<List<Customer>> getCustomers(String ownerId);

  // to get customers of a particular owner
  void getCustomerbyId(String custId);

  // to update a customers details
  Future<Customer> updateCustomerDetails(
    String customerId, {
    String name,
    String phoneNumber,
    String email,
    String lastName,
  });

  // to delete a customer
  Future<void> deleteCustomer(String customerId);
}

// if the database has an ID for each of the customers,
// then the Read, Update and Delete methods can make
// use of that property easily

class CustomerService implements ICustomerService {
  @override
  Future<void> addCustomer({
    String name,
    String phoneNumber,
    String email,
    String lastName,
  }) async {
    // TODO: implement addCustomerManually
    // awaiting API completion
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    // TODO: implement deleteCustomer
  }

  @override
  void getCustomerbyId(String customerId) {
    // TODO: implement getCustomerbyId
  }

  @override
  Future<List<Customer>> getCustomers(String ownerId) async {
    // TODO: implement getCustomers
  }

  @override
  Future<Customer> updateCustomerDetails(
    String customerId, {
    String name,
    String phoneNumber,
    String email,
    String lastName,
  }) async {
    // TODO: implement updateCustomerDetails
  }
}

class MockCustomerService implements ICustomerService {
  // Initialize a list to act like the database
  static List<Customer> _customers = List<Customer>.generate(
    10, // Change to change number of initial customers
    (index) => Customer.random(),
  );

  @override
  Future<void> addCustomer({
    String name,
    String phoneNumber,
    String email,
    String lastName,
  }) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 400));

    // Add the new customer while assigning a random Id to it
    // TODO: Make sure to take care of duplicate IDs
    _customers.add(
        Customer()
        ..name = name
        ..phone = phoneNumber
        ..email = email
        ..lastName = lastName
        );
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 400));

    // Remove the customer matching the id provided
    _customers.removeWhere((element) => element.id == customerId);
  }

  @override
  Future<List<Customer>> getCustomers(String ownerId) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 400));

    // Return the customers
    return _customers;
  }

  @override
  Future<Customer> updateCustomerDetails(
    String customerId, {
    String name,
    String phoneNumber,
    String email,
    String lastName,
  }) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 400));

    // Get the index of the customer to replace
    int indexToUpdate =
        _customers.indexWhere((element) => element.id == customerId);

    // Get the old customer before replacement
    Customer _customerToUpdate = _customers.elementAt(indexToUpdate);

    // Create a new customer object while replacing with the specified fields
    Customer customerReplacement = Customer()
      ..id = customerId
      ..name = name ?? _customerToUpdate.name
      ..phone =phoneNumber ?? _customerToUpdate.phone
      ..email = email ?? _customerToUpdate.email
      ..lastName = lastName ?? _customerToUpdate.lastName;

    // Update the customer at the position
    _customers[indexToUpdate] = customerReplacement;

    // return the new customer
    return customerReplacement;
  }

  @override
  Future<Customer> getCustomerbyId(String custId) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 400));

    // Return the customers
    return _customers.firstWhere((element) => element.id == custId);
  }
}
