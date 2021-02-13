import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

/*
var downloadrec=Transactionreciept(bid:2,cid:3,tid:2);
//to call
 onPressed: () async {
          downloadrec.writeOnPdf();
          await downloadrec.savePdf();
        },

*/
class Transactionreciept extends StatelessWidget {
  final bid; //business reference id
  final cid; //customer reference id
  final tid; //transaction reference id
  Transactionreciept(this.bid, this.cid, this.tid);
  var transactiontime = ""; // to be queried
  var customername = ""; //to be queried
  var amount = ""; //to be queried
  var businessname = ""; //to be queried
  var creditordebit = ""; //to be queried
  //need to add certain in future
  var fonti = pw.TextStyle(
    fontSize: 20,
  ); //need to change ,just defaultly used
  var pdf;

  writeOnPdf() {
    pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Center(
                  child:
                      pw.Text("Transaction ($transactiontime)", style: fonti)),
            ),
            pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    children: [
                  pw.Text('Customer Name:               $customername',
                      style: fonti),
                  pw.Text('Business Name:               $businessname',
                      style: fonti),
                  pw.Text('amount:                  $amount', style: fonti),
                ]))
          ];
        }));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    final time = DateTime.now();
    print(documentPath);
    File file = File("$documentPath/transaction$time.pdf");
    file.writeAsBytesSync(pdf.save());
    OpenFile.open("$documentPath/transaction$time.pdf");
    pdf = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

