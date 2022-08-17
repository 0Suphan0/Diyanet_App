import 'package:diyanet_app/Database/maintenance_forms_database.dart';
import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/static_product_database.dart';
import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Database/user_database.dart';
import 'package:diyanet_app/Models/maintenance_form_model.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
          child: Text("database test"),
          onPressed: () async {
            List<User> db1=await UserDatabase.instance.readAllUsers();
            List<MaintenanceForm> db2 =await MaintenanceFormDatabase.instance.readAllForms();
            List<Product> db3 =await ProductDatabase.instance.readAllProduct();
            List<UserAndProduct> db4 =await UserAndProductDatabase.instance.readAllUserAndProduct();
            //List<StaticProduct> db5= await StaticProductDatabase.instance.readAllProduct();
            for (var db in db4) {
               UserAndProductDatabase.instance.delete(db.tableId??0);
              // UserAndProductDatabase.instance.delete(db.tableId??0);
            // print(db.productName);
               // UserAndProductDatabase.instance.delete(db.userId??0);
             //print(db.productName);
             // UserAndProductDatabase.instance.delete(db.tableId??0);
             //print(user.tableId);
                //   print(user.userEmail);
                //  print(user.userPassword);
              //  print(user.formImprovementAreas);
                
            }
          }),
    );
  }
}
