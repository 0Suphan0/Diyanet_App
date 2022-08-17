import 'dart:typed_data';

import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makeAdminPdf(List<Product> allProduct) async {
  //print(allProduct.length);
  //var data = await rootBundle.load("fonts/IRANSansWeb(FaNum)_Bold.ttf");
  bool isExist=false;

  if(allProduct.length==0){
    isExist=false;
  }else{
    isExist=true;
  }
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/diyanet_logo.png')).buffer.asUint8List());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  pdf.addPage(
   
    Page(
      theme: ThemeData.withFont(
        
      ),
      build: (context) {
        
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Yayın Tarihi: 04.11.2020"),
                    Text("Dokuman No: PLN.240.20.07.02"),
                    Text("Revizyon No Tarihi:00/-"),
                    Text("Sayfa No: 1/1"),
                    Text("Gizlilik Tipi: GİZLİ"),
                    Text("Güncelleme Tarihi: ${formattedDate}"),
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
                        'YILLIK BAKIM VE TATBİKAT PLANI',
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
                     Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("NO").toString(),
                        textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("ÜrÜn Cinsi").toString(),
                        textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("Bakım / Tatbikat Sorumlusu").toString(),
                        textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("Bakım / Tatbikat Gerçekleştirecek Kişi / Kurum").toString(),
                        textAlign: TextAlign.center),
                      ),
                       Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("Bakım / Tatbikat Planı").toString(),
                        textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("Bakım / Tatbikat Notu").toString(),
                        textAlign: TextAlign.center),
                      ),
                       Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(("Bakım / Tatbikat Tipi").toString(),
                        textAlign: TextAlign.center),
                      ),
                  ],
                ),
                
              ],
            ),
            isExist?
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children:   List<TableRow>.generate(
                allProduct.length,
                (index) {
                  final product = allProduct[index];
                  return TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text((index+1).toString(),
                            textAlign: TextAlign.center),
                      ),
                     Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productName ?? "",
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productOperationMethod ?? "",
                            textAlign: TextAlign.center),
                      ),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productMaintainer ?? "",
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productMaintainerInstitution ?? "",
                            textAlign: TextAlign.center),
                      ),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productDoneTimes ?? "",
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productMaintainerNote ?? "",
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(product.productMaintenanceType ?? "",
                            textAlign: TextAlign.center),
                      ),
                     
                    ],
                  );
                },
                growable: false,
              ),
            ):Container()
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
