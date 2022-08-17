import 'dart:typed_data';

import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(MaintenanceForm maintenanceForm) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/diyanet_logo.png')).buffer.asUint8List());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Yayın Tarihi: 04.11.2020"),
                    Text("Dokuman No: FRM.240.20.07.02"),
                    Text("Revizyon No Tarihi:00/-"),
                    Text("Sayfa No: 1/1"),
                    Text("Güncelleme Tarihi: $formattedDate"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'DONANIM BAKIM FORMU',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Bakımı Yapılan Cihaz:'),
                    PaddedText(
                      '${maintenanceForm.formProductName}',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Bakım Tarihi:',
                    ),
                    PaddedText(
                      '${maintenanceForm.formMaintenanceDate}',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Bakımda Geçen Süre',
                    ),
                    PaddedText('${maintenanceForm.formMaintenancePassingTime}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Açıklama',
                    ),
                    PaddedText('${maintenanceForm.formExplanation}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Alınması Gereken Önlemler / Öneriler: (olumsuz bir durum olıştuğunda doldurulur.)',
                    ),
                    PaddedText('${maintenanceForm.formPreventionAndSuggestion}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'İyileştirme Alanları / Eksiklikler: (olumsuz bir durum olıştuğunda doldurulur.)',
                    ),
                    PaddedText('${maintenanceForm.formImprovementAreas}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Sonuç ve Değerlendirme',
                    ),
                    PaddedText('${maintenanceForm.formResult}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Bakım Sorumlusu',
                    ),
                    PaddedText('${maintenanceForm.formMaintenanceResponsible}')
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Kontrol Eden',
                    ),
                    PaddedText('${maintenanceForm.formPersonOfCheck}')
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
