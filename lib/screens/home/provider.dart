import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
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
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: data.keys.map((key) {
              final value = data[key];
              if (key == "patientDetails" ||
                  key == "emergencyContact" ||
                  key == "dietAndNutritions" ||
                  key == "lifestyle" ||
                  key == "advancehistoryList") {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(data[key][0]["header"],
                        style: pw.TextStyle(fontSize: 24)),
                    pw.SizedBox(height: 10),
                    pw.ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return pw.Column(
                          children: [
                            pw.Row(
                              children: [
                                pw.Expanded(
                                    child: pw.Text(value[index]["question"])),
                                pw.SizedBox(width: 10),
                                pw.Expanded(
                                    child: pw.Text(value[index]["answer"])),
                              ],
                            ),
                            pw.SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ],
                );
              } else if (key == "latestMedications") {
                return pw.Container();
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

  void sharePdf(data) async {
    final pdf = generatePdf(data!);

    await saveAndOpenPDF(pdf);

    // Share.shareXFiles([xFile], text: 'Share PDF');
  }

  Future<void> saveAndOpenPDF(Document pdf) async {
    try {
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (directory != null) {
        const fileName =
            'your_pdf_file_name1.pdf'; // Set your desired PDF file name here
        final filePath = '${directory.path}/$fileName';

        final savedFile = File(filePath);
        await savedFile.writeAsBytes(await pdf.save());

        log('PDF saved successfully to: $filePath');

        // Open the saved PDF file
        await OpenFile.open(filePath);
      } else {
        log('Could not access the storage directory.');
      }
    } catch (e) {
      log('Error saving/opening PDF: $e');
      // TODO: Handle any errors here
    }
  }

}
