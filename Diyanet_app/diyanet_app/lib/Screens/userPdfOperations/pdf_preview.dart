import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/userPdfOperations/send_form_and_picture_page.dart';
import 'package:diyanet_app/Screens/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';



class PdfPreviewPage extends StatelessWidget {
  final MaintenanceForm maintenanceForm;
  const PdfPreviewPage({Key? key, required this.maintenanceForm}) : super(key: key);
  static late User myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return UserHomePage(user: myUser,);
          }));
        }, child: Icon(Icons.home)),
        title: Text("PDF Önizleme"),
      ),
      body: PdfPreview(
        build: (context) => makePdf(maintenanceForm),
      ),
    );
  }
}