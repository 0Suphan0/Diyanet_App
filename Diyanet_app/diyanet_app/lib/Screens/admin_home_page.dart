import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/static_product_database.dart';
import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Screens/add_product_page.dart';
import 'package:diyanet_app/Screens/adminPdfOperations/admin_pdf_preview.dart';
import 'package:diyanet_app/Screens/admin_assigned_page_view.dart';
import 'package:diyanet_app/Screens/all_done_task_list_page.dart';
import 'package:diyanet_app/Screens/get_all_works_lists.dart';
import 'package:diyanet_app/Screens/task_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late List<UserAndProduct> _allUserAndProductRecords;
  late List<Product> _allRecords;
  //late List<StaticProduct> _allRecordsStatic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allRecords = [];
    _allUserAndProductRecords = [];
    // _allRecordsStatic=[];
    getMyProduct();
  }

  void getMyProduct() async {
    _allUserAndProductRecords =
        await UserAndProductDatabase.instance.readAllUserAndProduct();
    _allRecords = await ProductDatabase.instance.readAllProduct();
    // _allRecordsStatic = await StaticProductDatabase.instance.readAllProduct();
    // print(_allRecordsStatic[0].productName);
    print("object");
    // print(_allRecords[0].productName);
    AdminPdfPreview.allProduct = _allRecords;
    controlTaskDate();
  }

  void controlTaskDate() {
    print("Sadece burda");
    print(_allUserAndProductRecords.length);
    for (var i = 0; i < _allRecords.length; i++) {
      // print("Girdi control taska");
      getSystemDateAndControl(
          _allRecords[i].productDoneTimes ?? "", _allRecords[i]);
    }
  }

  getSystemDateAndControl(String doneTimes, Product product) {
    final split = doneTimes.split(',');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    // print("Ay??rma ba??ar??l??");
    // print(values); // {0: grubs, 1:  sheep}

    for (var i = 0; i < values.length; i++) {
      String myMonthValue = "0";
      // print("K??yas ba??lad??");
      if (values[i] == "OCAK") {
        myMonthValue = "01";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "??UBAT") {
        myMonthValue = "02";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "MART") {
        myMonthValue = "03";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "N??SAN") {
        myMonthValue = "04";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "MAYIS") {
        myMonthValue = "05";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "HAZ??RAN") {
        myMonthValue = "06";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "TEMMUZ") {
        //print("Temmuz bulundu");
        myMonthValue = "07";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "A??USTOS") {
        myMonthValue = "08";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "EYL??L") {
        myMonthValue = "09";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "EK??M") {
        myMonthValue = "10";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "KASIM") {
        myMonthValue = "11";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      } else if (values[i] == "ARALIK") {
        myMonthValue = "12";
        getCurrentMonthNumberAndControl(myMonthValue, product);
      }
    }
  }

  void getCurrentMonthNumberAndControl(String myMonth, Product product) {
    //print("temmuzun say??s??");
    //print(myMonth);
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String month = formatter.format(now);
    if (month == myMonth) {
      writeToDialog(myMonth, product);
      // _showDialog("Yakla??an g??rev var. G??rev atamas?? yap??n??z.");
    } else {
      //bi??ey yapma
    }
  }

  void writeToDialog(String myMonth, Product product) {
    String result = "";
    switch (myMonth) {
      case "01":
        result = "OCAK";
        break;
      case "02":
        result = "??UBAT";
        break;
      case "03":
        result = "MART";
        break;
      case "04":
        result = "N??SAN";
        break;
      case "05":
        result = "MAYIS";
        break;
      case "06":
        result = "HAZ??RAN";
        break;
      case "07":
        result = "TEMMUZ";
        break;
      case "08":
        result = "A??USTOS";
        break;
      case "09":
        result = "EYL??L";
        break;
      case "10":
        result = "EK??M";
        break;
      case "11":
        result = "KASIM";
        break;
      case "12":
        result = "ARALIK";
        break;
      default:
    }

    UserAndProduct userAndProduct = UserAndProduct(
        isTaskDone: 0,
        productDoneTimes: " ",
        productId: 0,
        productMaintainer: " ",
        productMaintainerInstitution: " ",
        productMaintainerNote: " ",
        userId: 0,
        productMaintenanceType: " ",
        productName: "",
        productOperationMethod: "",
        tableId: 0);

    for (var i = 0; i < _allUserAndProductRecords.length; i++) {
      if (product.productId == _allUserAndProductRecords[i].productId) {
        userAndProduct = _allUserAndProductRecords[i];
      }
    }

    if (userAndProduct.userId == 0) {
      if (userAndProduct.isTaskDone == 0) {
        _showDialog(
            "Yakla??an G??revler Mevcut ${result} AYI => ${product.productName}");
      }
    } else {
      print("Hi?? girmedi");
    }
  }

  //  _showDialog(
  //         "Yakla??an G??revler Mevcut ${result} AYI => ${product.productName}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("ADM??N sayfas??na ho??geldiniz.")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMenuItem(context, GelAllProductListPage(),
                "Y??ll??k Bak??m ????lemlerini Listele"),
            buildMenuItem(
                context, AddProductPage(), "Y??ll??k Bak??m ????lemi Ekle"),
            buildMenuItem(context, AssignTaskPage(), "G??rev Atamas?? Yap"),
            buildMenuItem(context, AssignedPageView(), "Atanm???? G??revler"),
            buildMenuItem(context, AdminPdfPreview(),
                "Y??ll??k Bak??m ve Tatbikat Plan?? Al"),
          ],
        ),
      ),
    );
  }

  InkWell buildMenuItem(BuildContext context, Widget widget, String text) {
    return InkWell(
        onTap: () {
          //
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return widget;
          }));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue,
                  offset: const Offset(
                    2.0,
                    2.0,
                  ),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            )),
          ),
        ));
  }

  _showDialog(String message) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Yakla??an G??revler'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
