import 'dart:ui';

import 'package:diyanet_app/Database/maintenance_forms_database.dart';
import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/all_done_task_list_page.dart';
import 'package:diyanet_app/Screens/userPdfOperations/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'all_done_task_list_page.dart';

class UserMaintenanceFormPage extends StatefulWidget {
  var UserAndProduct;

  UserMaintenanceFormPage({
    Key? key,
    required this.UserAndProduct,
  }) : super(key: key);

  // UserAndProduct userAndProduct= UserAndProduct(userId: 0, productId: 0, productName: "productName", productOperationMethod: "productOperationMethod", productMaintainer: "productMaintainer", productMaintainerInstitution: "productMaintainerInstitution", productDoneTimes: "productDoneTimes", productMaintainerNote: "productMaintainerNote", productMaintenanceType: "productMaintenanceType", isTaskDone: 0);
  static late User user;

  // static late UserAndProduct userAndProduct;
  @override
  State<UserMaintenanceFormPage> createState() =>
      _UserMaintenanceFormPageState();
}

class _UserMaintenanceFormPageState extends State<UserMaintenanceFormPage> {
  //controllerlar
  TextEditingController formNameCon = TextEditingController();
  TextEditingController formDateCon = TextEditingController();
  TextEditingController formMaintainingTime = TextEditingController();
  TextEditingController formProductExplanation = TextEditingController();
  TextEditingController formProductPreventionSuggestion =
      TextEditingController();
  TextEditingController formImprovementAreas = TextEditingController();
  TextEditingController formResultArea = TextEditingController();
  TextEditingController formMaintainer =
      TextEditingController(text: UserMaintenanceFormPage.user.userName);
  TextEditingController formPersonOfController =
      TextEditingController(text: "");

  late MaintenanceForm myForm;

  @override
  void initState() {
    super.initState();
    myForm = MaintenanceForm(
        formProductName: " ",
        formExplanation: " ",
        formImprovementAreas: " ",
        formMaintenanceDate: " ",
        formMaintenancePassingTime: " ",
        formMaintenanceResponsible: " ",
        formPersonOfCheck: " ",
        formPreventionAndSuggestion: "",
        formResult: " ");
    //widget.userAndProduct=UserAndProduct(userId: 0, productId: 0, productName: "productName", productOperationMethod: "productOperationMethod", productMaintainer: "productMaintainer", productMaintainerInstitution: "productMaintainerInstitution", productDoneTimes: "productDoneTimes", productMaintainerNote: "productMaintainerNote", productMaintenanceType: "productMaintenanceType", isTaskDone: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Donan??m Bak??m Formu"),
        ),
        body: Form(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: formNameCon,
                decoration: InputDecoration(
                    hintText: "Bak??m?? Yap??lan Cihaz",
                    labelText: "Bak??m?? Yap??lan Cihaz"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: formDateCon, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Tarihi Giriniz" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      formDateCon.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: formMaintainingTime,
                decoration: InputDecoration(
                    hintText: "Bak??mda Ge??en S??re",
                    labelText: "Bak??mda Ge??en S??re"),
              ),
              SizedBox(height: 10),
              TextFormField(
                minLines: 6,
                maxLines: 10,
                controller: formProductExplanation,
                decoration: InputDecoration(
                    hintText: "A????klama", labelText: "A????klama"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: formProductPreventionSuggestion,
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Al??nmas?? Gereken ??nlemler/ ??neriler",
                    labelText: "Al??nmas?? Gereken ??nlemler/ ??neriler"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: formImprovementAreas,
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "??yile??tirme Alanlar??/Eksiklikler",
                    labelText: "??yile??tirme Alanlar??/Eksiklikler"),
              ),
              TextFormField(
                controller: formResultArea,
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Sonu??/De??erlendirme",
                    labelText: "Sonu??/De??erlendirme"),
              ),
              TextFormField(
                controller: formMaintainer,
                decoration: InputDecoration(
                    enabled: false,
                    hintText: "Bak??m Sorumlusu",
                    labelText: "Bak??m Sorumlusu"),
              ),
              TextFormField(
                controller: formPersonOfController,
                decoration: InputDecoration(
                    enabled: false,
                    hintText: "Kontrol Eden",
                    labelText: "Kontrol Eden"),
              ),
              ElevatedButton(
                onPressed: () {
                  MaintenanceForm myForm2 = takeAndFillAllValue();
                  addToFormDb(myForm2);

                  //burada g??rev yap??ld?? i??aretle
                },
                child: Text("G??nder"),
              )
            ],
          ),
        )));
  }

  MaintenanceForm takeAndFillAllValue() {
    myForm.formProductName = formNameCon.text;
    myForm.formMaintenanceDate = formDateCon.text;
    myForm.formMaintenancePassingTime = formMaintainingTime.text;
    myForm.formExplanation = formProductExplanation.text;
    myForm.formPreventionAndSuggestion = formProductPreventionSuggestion.text;
    myForm.formImprovementAreas = formImprovementAreas.text;
    myForm.formResult = formResultArea.text;
    myForm.formMaintenanceResponsible = formMaintainer.text;
    myForm.formPersonOfCheck = formPersonOfController.text;

    return myForm;
  }

  void addToFormDb(MaintenanceForm myForm2) {
    setState(() {
      MaintenanceFormDatabase.instance.create(myForm2);

      //g??rev yap??ld??
      //UserMaintenanceFormPage.userAndProduct.isTaskDone = 1;
      //  widget.UserAndProduct.isTaskDone=1;
      UserAndProductDatabase.instance.update(widget.UserAndProduct, 1);
      PdfPreviewPage.myUser = UserMaintenanceFormPage.user;
      // print("Ba??ar??l??");
      //DoneTaskPage.myDoneList.add(widget.UserAndProduct);
      //UserAndProductDatabase.instance.delete(widget.UserAndProduct.tableId);
      //ProductDatabase.instance.delete(widget.UserAndProduct.productId); g??revin kendisi silinmesin tablo olarak ????kacak.
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PdfPreviewPage(maintenanceForm: myForm2);
      }));
    });
  }
}
