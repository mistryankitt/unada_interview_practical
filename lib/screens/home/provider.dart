import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unada_interview/model/list_model.dart';
import 'package:unada_interview/service/api_service.dart';

class HomeProvider extends ChangeNotifier {
  int _showAnswerIndex = 0;

  isDetailsOpenM(value) {
    _showAnswerIndex = value;
    notifyListeners();
  }

  Future<dynamic> getListApiM() async {
    return await ApiService.getAllApi();
  }

  pw.Document generatePdf(Map<String, dynamic> data) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: data.keys.map((key) {
              final value = data[key];

              // for (var item in value){
              //   for (var subItem in item.keys) {
              //     debugPrint("{$subItem  ${item[subItem]}}");
              //   }
              // }




              if (key == "patientDetails" ||
                  key == "emergencyContact" ||
                  key == "latestSymptoms" ||
                  key == "familyHistory" ||
                  key == "dietAndNutritions" ||
                  key == "lifestyle" ||
                  key == "treatments" ||
                  key == "hospitalizations" ||
                  key == "insurancePolicies" ||
                  key == "advancehistoryList") {
                return pw.Container(
                  margin: pw.EdgeInsets.only(bottom: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "ankit",
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                );
              } else if (key == "latestMedications") {
                return pw.Container(
                  margin: pw.EdgeInsets.only(top: 10),
                  // child: pw.Column(
                  //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //   children: [
                  //     pw.Text(
                  //       value["header"],
                  //       style: pw.TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: pw.FontWeight.bold,
                  //       ),
                  //     ),
                  //     for (var lmKey in value.keys)
                  //       pw.Row(
                  //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           pw.Text(
                  //             lmKey,
                  //             style: pw.TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: pw.FontWeight.bold,
                  //             ),
                  //           ),
                  //           pw.Text(
                  //             value[lmKey].toString(),
                  //             style: pw.TextStyle(
                  //               fontSize: 14,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //   ],
                  // ),
                );
              } else {
                return pw.Container();
              }
            }).toList(),
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/images/img.png",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  void sharePdf(data) async{

    final pdf = generatePdf(data!);

    // Save the PDF to a temporary file

    final tempDir =
        await getTemporaryDirectory();
    final tempFilePath =
        '${tempDir.path}/example.pdf';
    // Save the PDF as an XFile
    final xFile = XFile.fromData(
        await pdf.save(),
        path: tempFilePath,
    );

    if (Platform.isLinux) {
    Process.run('xdg-open', [xFile.path]); // Requires 'xdg-utils' package
    } else {

    // Share the PDF using XFile
    Share.shareXFiles([xFile],
    text: 'Share PDF');
    }
  }
}


buildPrintableData(image) => pw.Padding(
  padding: const pw.EdgeInsets.all(25.00),
  child: pw.Column(children: [
    pw.Text("vijaycreations",
        style:
        pw.TextStyle(fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
    pw.SizedBox(height: 10.00),
    pw.Divider(),
    pw.Align(
      alignment: pw.Alignment.topRight,
      child: pw.Image(
        image,
        width: 250,
        height: 250,
      ),
    ),
    pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.SizedBox(width: 5.5),
            pw.Text(
              "Invoice",
              style: pw.TextStyle(
                  fontSize: 23.00, fontWeight: pw.FontWeight.bold),
            )
          ],
        ),
        pw.SizedBox(height: 10.00),
        pw.Container(
          color: const PdfColor(0.5, 1, 0.5, 0.7),
          width: double.infinity,
          height: 36.00,
          child: pw.Center(
            child: pw.Text(
              "Approvals",
              style: pw.TextStyle(
                  color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                  fontSize: 20.00,
                  fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        for (var i = 0; i < 3; i++)
          pw.Container(
            color: i % 2 != 0
                ? const PdfColor(0.9, 0.9, 0.9, 0.6)
                : const PdfColor(1, 1, 1, 0.1),
            width: double.infinity,
            height: 36.00,
            child: pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  i == 2
                      ? pw.Text(
                    "Tax",
                    style: pw.TextStyle(
                        fontSize: 18.00,
                        fontWeight: pw.FontWeight.bold),
                  )
                      : pw.Text(
                    "Item ${i + 1}",
                    style: pw.TextStyle(
                        fontSize: 18.00,
                        fontWeight: pw.FontWeight.bold),
                  ),
                  i == 2
                      ? pw.Text(
                    "\$ 2.50",
                    style: pw.TextStyle(
                        fontSize: 18.00,
                        fontWeight: pw.FontWeight.normal),
                  )
                      : pw.Text(
                    "\$ ${(i + 1) * 7}.00",
                    style: pw.TextStyle(
                        fontSize: 18.00,
                        fontWeight: pw.FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
          child: pw.Container(
            width: double.infinity,
            height: 36.00,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "\$ 23.50",
                  style: pw.TextStyle(
                    fontSize: 22.00,
                    fontWeight: pw.FontWeight.bold,
                    color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        pw.SizedBox(height: 15.00),
        pw.Text(
          "Thanks for choosing our service!",
          style: const pw.TextStyle(
              color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
        ),
        pw.SizedBox(height: 5.00),
        pw.Text(
          "Contact the branch for any clarifications.",
          style: const pw.TextStyle(
              color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
        ),
        pw.SizedBox(height: 15.00),
      ],
    )
  ]),
);