import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/add_product_page.dart';
import 'package:diyanet_app/Screens/adminPdfOperations/admin_pdf_preview.dart';
import 'package:diyanet_app/Screens/admin_assigned_page_view.dart';
import 'package:diyanet_app/Screens/admin_home_page.dart';
import 'package:diyanet_app/Screens/get_all_works_lists.dart';
import 'package:diyanet_app/Screens/login_page.dart';
import 'package:diyanet_app/Screens/register_page.dart';
import 'package:diyanet_app/Screens/task_assignment_page.dart';
import 'package:diyanet_app/Screens/test_demo.dart';
import 'package:diyanet_app/Screens/user_home_page.dart';
import 'package:diyanet_app/Screens/user_maintenance_form.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        
      ),
      home:AdminHomePage()
    );
  }
}
