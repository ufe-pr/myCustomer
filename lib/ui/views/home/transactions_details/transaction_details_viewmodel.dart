import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:mycustomers/core/utils/logger.dart';

class TransactionDetailsViewModel extends ReactiveViewModel{
  final NavigationService _navigationService = locator<NavigationService>();
  
  final _customerContactService = locator<CustomerContactService>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  CustomerContact get contact => _customerContactService.contact;
  TransactionModel get transaction => _transactionService.stransaction;

  File imageFile;

  String name = 'Seyi Onifade';
  int phoneNumber = 09045678901;
  String itemsPurchased = '2 Crates of 50CL Coke';
  int costOfItems = 50000;
  int amountPaid = 20000;
  int amountOwing = 30000;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService, _customerContactService];

  Future<void> shareTextandImage() async {
    try {
       final Uint8List bytes =await imageFile.readAsBytes();
      final String fileName =
          '${contact.name}-Transactiondetail.pdf';
      //final ByteData bytes = await rootBundle.load('assets/images/app_icon.png');
      await WcFlutterShare.share(
          sharePopupTitle: 'Share',
          subject: contact.name,
          text: 'Transaction with ${contact.name}',
          fileName: fileName,
          mimeType: 'file/pdf',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      Logger.e(e.toString());
      throw Exception("Unable to share file");
    }
  }

}