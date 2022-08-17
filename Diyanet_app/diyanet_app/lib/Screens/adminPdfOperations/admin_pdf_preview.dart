import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:diyanet_app/Screens/adminPdfOperations/get_table_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';

class AdminPdfPreview extends StatelessWidget {
   AdminPdfPreview({Key? key}) : super(key: key);

  static List<Product> allProduct=[];
   
  @override
  

  
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Önizleme'),
      ),
      body: PdfPreview(
        
        build: (context) => makeAdminPdf(allProduct),
      ),
    );
  }
}
