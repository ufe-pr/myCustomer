import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/models/hive/log/log_h.dart';
import 'package:mycustomers/core/models/hive/store/store_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/main.dart';
import 'package:mockito/mockito.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';

class MockTransactionAdapter extends Mock implements TransactionDataSource {}

class MockHive extends Mock implements HiveInterface {}

class MockBox<T> extends Mock implements Box<T> {}

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TransactionAdapter());

  //To make sure the box is clean.
  Hive.deleteBoxFromDisk('transactionBox');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final transactionModel1 = TransactionModel(
      cId: 'aaab',
      amount: 20000.0,
      paid: 0,
      description: 'Rice',
      duedate: '08/07/2020');
  final transactionModel2 = TransactionModel(
      cId: 'qqknk',
      amount: 0,
      paid: 9000.0,
      description: 'Rice',
      duedate: '05/07/2020');
  final transactionModel3 = TransactionModel(
      cId: 'nwjdm',
      amount: 300.0,
      paid: 0,
      description: 'Rice',
      duedate: '03/07/2020');

  final transactionModeList = [
    transactionModel1,
    transactionModel2,
    transactionModel3
  ];

  testWidgets('App should work', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    //initialiseHive();
    locator.allowReassignment = true;

    setupLogger(test: true);

    final mockTransactionAdapters = MockTransactionAdapter();

    final transactionmockBox = MockBox<TransactionModel>();
    final logmockBox = MockBox<LogH>();
    final businessCardMockBox = MockBox<BusinessCardH>();
    final currencymockBox = MockBox<CountryCurrency>();
    final storemockBox = MockBox<StoreH>();
    final contactmockBox = MockBox<CustomerContact>();

    final mockhive = MockHive();

    when(mockhive.isBoxOpen(HiveBox.transaction)).thenAnswer((_) => false);
    when(mockhive.isBoxOpen(HiveBox.logs)).thenAnswer((_) => false);
    when(mockhive.isBoxOpen(HiveBox.currency)).thenAnswer((_) => false);
    when(mockhive.isBoxOpen(HiveBox.businessCardBoxName)).thenAnswer((_) => false);
    when(mockhive.isBoxOpen(HiveBox.contact)).thenAnswer((_) => false);

    when(mockhive.openBox<TransactionModel>(HiveBox.transaction))
        .thenAnswer((_) async => Future.value(transactionmockBox));
    when(mockhive.openBox<LogH>(HiveBox.logs))
        .thenAnswer((_) async => Future.value(logmockBox));
    when(mockhive.openBox<BusinessCardH>(HiveBox.businessCardBoxName))
        .thenAnswer((_) async => Future.value(businessCardMockBox));
    when(mockhive.openBox<CountryCurrency>(HiveBox.currency))
        .thenAnswer((_) async => Future.value(currencymockBox));
    when(mockhive.openBox<StoreH>('STORE'))
        .thenAnswer((_) async => Future.value(storemockBox));
    when(mockhive.openBox<CustomerContact>(HiveBox.contact))
        .thenAnswer((_) async => Future.value(contactmockBox));

    locator.registerSingleton<TransactionDataSource>(mockTransactionAdapters);
    locator.registerSingleton<HiveInterface>(mockhive);

    //DI && IC
    SharedPreferences.setMockInitialValues({});
    await setupLocator(useMockContacts: true, test: true);

    //Mock
    await locator.allReady();
    IOwnerServices iOwnerServices = locator<IOwnerServices>();
    MockPermissions _permission = locator<IPermissionService>();

    //Checking for contact service
    await tester.runAsync(() async {
      mockTransactionAdapters.init();
      when(iOwnerServices.getPhoneContacts()).thenAnswer((realInvocation) =>
          Future.value(List<Customer>.generate(5, (int) => Customer.random())));
      when(_permission.getContactsPermission())
          .thenAnswer((realInvocation) => Future.value(false));
      when(transactionmockBox.values).thenReturn(transactionModeList);
      await tester.pumpWidget(App());
    });

    await tester.pumpWidget(App());

    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  });
}
