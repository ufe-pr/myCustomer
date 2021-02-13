import 'storagepermission.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
// import 'package:downloads_path_provider/downloads_path_provider.dart';
/*
usage:
import 'Downloads/customerList.dart';
onPressed()
{
customerListWriteOnPdf();
}
 */

var sty1 = pw.TextStyle(
    fontWeight: pw.FontWeight.bold, fontSize: 16, color: PdfColors.grey);
var sty3 = pw.TextStyle(fontSize: 14);
var sty2 = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14);
var pdf;
customerListWriteOnPdf() async {
  await storagePermission();
  pdf = pw.Document();
  final time =
      "25/06/20 09:05pm                                                      ";
  final number = 1;
  final credit = "N1000";
  final debit = "N1000";
  final trid = "0001-0001";
  const tableHeaders = [
    'S.NO     ',
    '     Date           ',
    '           Name             ',
    '             Remark              ',
    '        Recieved        ',
    '                Gave               ',
  ];
  final List<ContentData> contentBody = [
    ContentData(1, '22/06/20\n02:02pm', 'Seyi Onifade', 'Nil', 'N500', ''),
    ContentData(2, '22/06/20\n02:02pm', 'Seyi Onifade', 'Nil', '', 'N500'),
    ContentData(3, '22/06/20\n02:02pm', 'Seyi Onifade', 'Nil', 'N500', ''),
    ContentData(4, '22/06/20\n02:02pm', 'Seyi Onifade', 'Nil', '', 'N500'),
    ContentData(5, '', '', 'Total', 'N1000', 'N1000'),

    //ContentData(9, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    /*ContentData(10, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(11, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(12, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(13, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(14, 'Demola', 'Today', 23.0, 25.02, 'Saved'),
    ContentData(15, 'Demola', 'Today', 23.0, 25.02, 'Saved'),*/
  ];

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                pw.Text("myCustomer",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18)),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Wearsmute", style: pw.TextStyle(fontSize: 18)),
                      pw.Text("9110396669", style: sty1),
                    ])
              ])),

          pw.SizedBox(
            height: 40,
            width: double.infinity,
          ),
          pw.Container(
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Text(
                      "Transactions Report ( 10/06/20 - 17/06/20 )",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 18),
                    ),
                  ]),
                  pw.SizedBox(height: 40, width: double.infinity),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Report Generated at:",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                "Transaction ID:",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                "Number of Customers :",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                "Total Recieved:",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                "Total Gained:",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                            ]),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("$time"),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text("$trid"),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text("$number"),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text("$credit",
                                  style: pw.TextStyle(color: PdfColors.green)),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text("$debit",
                                  style: pw.TextStyle(color: PdfColors.red)),
                              pw.SizedBox(
                                height: 5,
                              ),
                            ])
                      ]),
                  pw.SizedBox(height: 34),
                  pw.Row(children: [
                    pw.Text("Customer : Seyi Onifade",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 18)),
                  ])
                ]),
          ),
          pw.SizedBox(height: 40),

          pw.Table.fromTextArray(
            border: null,
            cellAlignment: pw.Alignment.center,
            headerDecoration: pw.BoxDecoration(
              // borderRadius: 2,
              color: PdfColors.grey300,
            ),
            headerHeight: 30,
            cellHeight: 40,
            //TODO: how does cellAlignments work

            headerStyle: pw.TextStyle(
              color: PdfColors.deepPurple900,
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
          ),

//          Report Generated At : 15/06/2020 09:46 pm
//          Number of Customers : 1 / 1
//          Total Amount They'll Receive : ₹ 2.00
//          Total Amount They'll Pay : ₹ 0.00
//          Final Balance :
        ];
      }));
  await savePdf();
}

Future savePdf() async {
  // Directory downloadsDirectory1 = await DownloadsPathProvider.downloadsDirectory;
  // String documentPath1 = downloadsDirectory1.path;
  Directory downloadsDirectory = await getExternalStorageDirectory();
  String documentPath = downloadsDirectory.path;
  final time = DateTime.now();
  print(documentPath.toUpperCase());
  File file = File("$documentPath/transaction$time.pdf");
  print(file);
  file.writeAsBytesSync(pdf.save());
  OpenFile.open("$documentPath/transaction$time.pdf");
  pdf = null;
}

class ContentData {
  const ContentData(
      this.SNO, this.Date, this.Name, this.Note, this.Received, this.Gave);

  final int SNO;
  final String Name;
  final String Date;
  final String Note;
  final String Received;
  final String Gave;

  //TODO: create a function with a loop to do live data

  getIndex(int index) {
    switch (index) {
      case 0:
        return SNO;
      case 1:
        return Date;
      case 2:
        return Name;
      case 3:
        return Note;
      case 4:
        return Received;
      case 5:
        return Gave;
    }
  }
}

//                pw.Row(
//                  //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                  children: [
//                    pw.Text("Report Generated at:",style: sty3),
//                    pw.SizedBox(
//
//                        width: 0
//                    ),
//                    pw.Text("$time",style: sty1),
//                  ]
//                ),
//                pw.SizedBox(
//                    height: 20,
//                    width: double.infinity
//                ),
//                pw.Row(
//                  //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                    children: [
//                      pw.Text("Transaction ID:",style: sty3),
//                      pw.SizedBox(
//
//                          width: 0
//                      ),
//                      pw.Text("$trid",style: sty1),
//                    ]
//                ),
//                pw.SizedBox(
//                    height: 20,
//                    width: double.infinity
//                ),
//                pw.Row(
//                    //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                    children: [
//                      pw.Text("Number of Customers :",style: sty3),
//                      pw.SizedBox(
//
//                          width: 0
//                      ),
//                      pw.Text("$number",style: sty1),
//                    ]
//                ),
//                pw.SizedBox(
//                    height: 20,
//                    width: double.infinity
//                ),
//                pw.Row(
//
//                    children: [
//                      pw.Text("Total Recieved:  ",style: sty3),
//                      pw.SizedBox(
//
//                          width: 0
//                      ),
//                      pw.Text("$credit",style: sty1),
//                    ]
//                ),
//                pw.SizedBox(
//                    height: 20,
//                    width: double.infinity
//                ),
//                pw.Row(
//
//                    children: [
//                      pw.Text("Total Gave:  ",style: sty3),
//                      pw.SizedBox(
//
//                          width: 0
//                      ),
//                      pw.Text("$debit",style: sty1),
//                    ]
//                ),
//                pw.SizedBox(
//                    height: 20,
//                    width: double.infinity
//                ),
