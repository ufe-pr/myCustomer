import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'storagepermission.dart';

import 'creditors_transaction_report_viewmodel.dart';

class CreditorsTransactionReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditorsTransactionReportViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("PDF"),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Get Report',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blue,
                onPressed: () {
                  CreditorsReport().buildPdf(context);
                },
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CreditorsTransactionReportViewModel(),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      path: path,
    );
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

String _formatCurrency(double amount) {
  return '\N${amount.toStringAsFixed(2)}';
}

/// Class CreditorsReport for View

class CreditorsReport {

  var updatedDt;

  CreditorsReport() {
    var dt = DateTime.now();
    updatedDt = DateFormat.Hms().format(dt);
  }
  var doc;

  // List of type 'Data'
  final List<ContentData> contentBody = [
    ContentData(1, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(2, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(3, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(4, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(5, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(6, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(7, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(8, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(9, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(10, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(11, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(12, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(13, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(14, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(15, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
  ];

  final List<FooterData> footerBody = [
    FooterData(100.0, 100.0),
  ];

  PdfImage _image;

  Future<Uint8List> buildPdf(BuildContext context) async {
    await storagePermission();

    // Create a PDF document.
    doc = pw.Document();

    _image = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/icons/my_customer_logo.png'))
          .buffer
          .asUint8List(),
    );

    // Add multiple pages to the PDF
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentBody(context),
          _contentFooter(context),
        ],
      ),
    );

    //TODO: Add 'await'
    generateReport(context);
    // Return the PDF file content
    //return doc.save();
  }

  /// Build Components
  pw.Widget _buildHeader(pw.Context context) {
    //TODO: Add margin to both _buildHeader & _contentBody
    return pw.Row(
      children: <pw.Widget>[
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Container(
                width: 150.0,
                height: 200.0,
                child: pw.Image(_image),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Container(
                //TODO: change to date generated and color to grey
                child: pw.Text(
                  _formatDate(DateTime.now()),
                  style: pw.TextStyle(
                    color: PdfColors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Container(
                    child: pw.Text(
                      "Monthly Report",
                      style: pw.TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  pw.Container(
                    //TODO: change from hardcoded data
                    child: pw.Text(
                      "@BioChris",
                      style: pw.TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Divider(
                color: PdfColors.black,
                height: 10.0,
                thickness: 1.0,
              ),
              pw.SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(
      children: <pw.Widget>[
        pw.SizedBox(
          height: 50,
        ),
        pw.Row(
          children: <pw.Widget>[
            pw.Container(
              width: 150.0,
              height: 200.0,
              child: pw.Image(_image),
            ),
          ],
        ),
        pw.Container(
          color: PdfColor.fromInt(0xFF333CC1),
          padding: pw.EdgeInsets.all(7),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            mainAxisSize: pw.MainAxisSize.max,
            children: <pw.Widget>[
              pw.Container(
                child: pw.RichText(
                  text: pw.TextSpan(
                    children: <pw.TextSpan>[
                      pw.TextSpan(
                        text: 'https://mycustomer.io',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Container(
                child: pw.RichText(
                  text: pw.TextSpan(
                    children: <pw.TextSpan>[
                      pw.TextSpan(
                        text:
                            'Page ${context.pageNumber} of ${context.pagesCount}',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentBody(pw.Context context) {
    //TODO: set to type <String>
    const tableHeaders = [
      'S/N',
      'Customer Name',
      'Date',
      'Remark',
      'Credit',
      'Debit',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(
        // borderRadius: 2,
        color: PdfColor.fromInt(0xFF333CC1),
      ),
      headerHeight: 30,
      cellHeight: 40,
      //TODO: how does cellAlignments work
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: 1,
        ),
      ),
      headers: List.generate(
        tableHeaders.length,
        (headerTitle) => tableHeaders[headerTitle],
      ),
      // TODO: check <List<String>> function
      data: List.generate(
        contentBody.length,
        (row) => List.generate(
          tableHeaders.length,
          (bodyItems) =>
              contentBody[row].getIndex(bodyItems), // getting the items
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    const tableFooters = [
      'Total',
      'Balance',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerRight,
      headerDecoration: pw.BoxDecoration(
        // borderRadius: 2,
        color: PdfColor.fromInt(0xFF333CC1),
      ),
      headerHeight: 30,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        //color: PdfColor.fromInt(0xFF333CC1),
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.black,
          width: 1,
        ),
      ),
      headers: List.generate(
        tableFooters.length,
        (footerTitle) => tableFooters[footerTitle],
      ),
      data: List.generate(
        footerBody.length,
        (row) => List.generate(
          tableFooters.length,
          (footerItems) =>
              footerBody[row].getIndex(footerItems), // getting the items
        ),
      ),
    );
  }

  Future<void> generateReport(BuildContext context) async {
    final Directory appDocDir = await getExternalStorageDirectory();
    final String appDocPath = appDocDir.path;
    final String path = '$appDocPath/report' + updatedDt + '.pdf';
    File file = File(path);
    print('Save as file ${file.path} ...');
    file.writeAsBytesSync(doc.save());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }
}

/// Data
class FooterData {
  const FooterData(this.creditBal, this.debitBal);

  final double creditBal;
  final double debitBal;

  double get total => creditBal - debitBal;

  getIndex(int index) {
    switch (index) {
      case 0:
        return _formatCurrency(creditBal);
      case 1:
        return _formatCurrency(debitBal);
      case 2:
        return _formatCurrency(total);
    }
  }
}

class ContentData {
  const ContentData(
    this.sn,
    this.customerName,
    this.date,
    this.credit,
    this.debit,
    this.remark,
  );

  final int sn;
  final String customerName;
  final String date;
  final String remark;
  final double credit;
  final double debit;

  //TODO: create a function with a loop to do live data

  getIndex(int index) {
    switch (index) {
      case 0:
        return sn;
      case 1:
        return customerName;
      case 2:
        return _formatDate(DateTime.now());
      case 3:
        return remark;
      case 4:
        return _formatCurrency(credit);
      case 5:
        return _formatCurrency(debit);
    }
  }
}
