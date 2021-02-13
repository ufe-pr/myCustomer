import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'storagepermission.dart';

String _formatDate(DateTime date) {
  //TODO: Update to accept transaction time
  final format = DateFormat.yMMMMEEEEd('en_US');

  return format.format(date);
}

String _formatCurrency(double amount) {
  return '\N${amount.toStringAsFixed(2)}';
}

class ReceiptReport {
  var updatedDt;

  ReceiptReport() {
    var dt = DateTime.now();
    updatedDt = DateFormat.Hms().format(dt);
  }

  var doc;

  // String _currentStore = StoreRepository.currentStore.name = "Demo";
  // String _currentStoreAddress = StoreRepository.currentStore.address;

  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  TransactionModel get transaction => _transactionService.stransaction;

  PdfImage _receiptLogo;
  PdfImage _mainLogo;

  Future<File> buildPdf(BuildContext context) async {
    await storagePermission();
    doc = pw.Document();

    _receiptLogo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/receiptLogo.png'))
          .buffer
          .asUint8List(),
    );

    _mainLogo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/icons/my_customer_logo.png'))
          .buffer
          .asUint8List(),
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: <pw.Widget>[
              /// Background
              pw.Center(
                child: pw.Container(
                  foregroundDecoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFF8FAFA),
                  ),
                ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Container(
                        margin: pw.EdgeInsets.only(bottom: 30),
                        width: 250,
                        height: 250,
                        child: pw.Image(_receiptLogo),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                margin: pw.EdgeInsets.only(
                    right: 50, top: 25, left: 50, bottom: 80),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                          child: pw.Image(
                            _mainLogo,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      //TODO: Use date of transaction here
                      _formatDate(DateTime.now()),
                      style: pw.TextStyle(
                        color: PdfColors.grey,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 15),
                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'Single Transaction Details: ',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        children: [
                          pw.TextSpan(
                            //TODO: Add transaction ID
                            text: //transaction.cId.toString(),
                            '1100-001',
                            style: pw.TextStyle(
                              color: PdfColors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                margin: pw.EdgeInsets.only(
                    right: 50, top: 150, left: 50, bottom: 120),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                ),
                child: pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  children: <pw.Widget>[
                    pw.Expanded(
                      child: pw.Column(
                        mainAxisSize: pw.MainAxisSize.max,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            margin: pw.EdgeInsets.only(
                                top: 25, left: 30, bottom: 25),
                            child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                //TODO: Populate with live data customer
                                // store name and address
                                pw.Text(
                                  "Demo",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                                pw.SizedBox(height: 10),
                                pw.Container(
                                  margin: pw.EdgeInsets.only(right: 30),
                                  child: pw.RichText(
                                    maxLines: 3,
                                    text: pw.TextSpan(
                                      text: "No.1, None of your business "
                                          "lane, Fredfort frankfurt lane, Off"
                                          " Boulevard drive, Lagos Hamilton "
                                          "Drive, UK Nigeria, North-east "
                                          "Africa",
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),

                                pw.SizedBox(height: 2.5),
                              ],
                            ),
                          ),
                          pw.Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: PdfColor.fromInt(0xFFC4C4C4),
                          ),
                          pw.Container(
                            margin: pw.EdgeInsets.only(
                                top: 25, left: 30, bottom: 25),
                            child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.max,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Description',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Container(
                                  margin: pw.EdgeInsets.only(right: 30),
                                  child: pw.Text(
                                    "We help you to manage your business and "
                                    "keep track of records, "
                                    "Easily manage customers owing you and "
                                    "increase your cash flow, "
                                    "Interact with your customers through "
                                    "pushing of unique sales messaging.",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                    ),
                                    maxLines: 3,
                                    softWrap: true,
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(left: 30, right: 30),
                            //TODO: Create a class and Populate with
                            // live data
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Items purchased:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    // for (var item in transaction.goods)
                                    //   pw.Text(
                                    //     //TODO: Enter live items here
                                    //     transaction.goods.indexOf(item) ==
                                    //             transaction.goods.length - 1
                                    //         ? item + ' '
                                    //         : item + ', ',
                                    //     style: pw.TextStyle(
                                    //       fontSize: 8,
                                    //     ),
                                    //   ),
                                    pw.Text(
                                      //transaction.description,
                                      'Some Items',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    )
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Cost of Items:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      // transaction.amount != null
                                      //     ? '${_formatCurrency(transaction.amount)}'
                                      //     : _formatCurrency(0),
                                      'N80,000',
                                      style: pw.TextStyle(
                                        color: PdfColor.fromInt(0xFF333CC1),
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Paid:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      // transaction.paid != null
                                      //     ? '${_formatCurrency(transaction.paid)}'
                                      //     : _formatCurrency(0),
                                      'N80,000',
                                      style: pw.TextStyle(
                                        color: PdfColors.green,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Owing:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      // transaction.amount != null &&
                                      //         transaction.paid != null &&
                                      //         (transaction.amount -
                                      //                 transaction.paid) >
                                      //             0
                                      //     ? '${_formatCurrency(transaction.amount - transaction.paid)}'
                                      //     : _formatCurrency(0),
                                      'N80,000',
                                      style: pw.TextStyle(
                                        color: PdfColors.red,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Amount Owed:',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                    pw.Text(
                                      // transaction.paid != null &&
                                      //         transaction.amount != null &&
                                      //         (transaction.paid -
                                      //                 transaction.amount) >
                                      //             0
                                      //     ? '${_formatCurrency(transaction.paid - transaction.amount)}'
                                      //     : _formatCurrency(0),
                                      'N80,000',
                                      style: pw.TextStyle(
                                        color: PdfColors.red,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ], // _contentBody(context),
                            ),
                          ),
                          pw.SizedBox(
                            height: 40,
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(
                                left: 30, top: 10, bottom: 10, right: 30),
                            color: PdfColor.fromInt(0xFF333CC1),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.center,
                            padding: pw.EdgeInsets.all(30),
                            child: pw.Image(
                              _mainLogo,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    margin: pw.EdgeInsets.only(bottom: 40, right: 190),
                    child: pw.Text(
                      'THANK YOU FOR YOUR PATRONAGE!',
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColor.fromInt(0xFF1D6AFF),
                      ),
                    ),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.only(
                        left: 50, right: 50, bottom: 15, top: 15),
                    color: PdfColor.fromInt(0xFF333CC1),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'myCustomer',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        pw.Column(
                          children: [
                            pw.Text(
                              'http://www.customerpay.me/',
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 6,
                              ),
                            ),
                            pw.Text(
                              'me@mycustomer.com',
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return await generateReport(context);
  }

  Future<File> generateReport(BuildContext context) async {
    final Directory appDocDir = await getExternalStorageDirectory();
    final String appDocPath = appDocDir.path;
    final String path = '$appDocPath/report' + updatedDt + '.pdf';
    File file = File(path);
    print('Save as file ${file.path} ...');
    file.writeAsBytesSync(doc.save());
    return file;

    //OpenFile.open(path);
  }
}