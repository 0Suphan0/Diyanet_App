import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class DoneTaskPage extends StatefulWidget {
  DoneTaskPage({Key? key}) : super(key: key);

  static List<UserAndProduct> myDoneList = [];

  @override
  State<DoneTaskPage> createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  late List<User> _userRecords;

  @override
  void initState() {
    super.initState();
    _userRecords = [];
  }

  @override
  Widget build(BuildContext context) {
    return _userRecords.length == 0
        ? Scaffold(
            appBar: AppBar(title: Text("Görevi Tamamlayanlar")),
            body: Container(
              child: Center(child: Text("Yapılan Görev Yok")),
            ))
        : ListView.builder(
            itemCount: DoneTaskPage.myDoneList.length,
            itemBuilder: (_, int position) {
              return ListTile(
                title:
                    Text(DoneTaskPage.myDoneList[position].productName ?? ""),
                subtitle: Text(createMyName(
                    DoneTaskPage.myDoneList[position].userId ?? 0)),
              );
            });
  }

  String createMyName(int position) {
    for (var user in _userRecords) {
      if (user.userId == position) {
        return user.userName ?? "";
      }
    }

    return "";
  }
}
