import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Database/user_database.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class AssignTaskPage extends StatefulWidget {
  AssignTaskPage({Key? key}) : super(key: key);

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {
  late List<User> _userRecords;
  late List<Product> _productRecords;
  late List<UserAndProduct> _userAndProductRecords;
  late int selectedUserId;
  late Product selectedProduct;
  late UserAndProduct myUserAndProductObject;
  late User mySelectedUser;

  TextEditingController userTextController = TextEditingController();
  TextEditingController taskTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userRecords = [];
    _productRecords = [];
    _userAndProductRecords = [];
    _getUserRecords();
    _getProductRecords();
    _getUserAndProductRecords();

    myUserAndProductObject = UserAndProduct(
      userId: 0,
      productId: 0,
      productDoneTimes: " ",
      productMaintainer: " ",
      productMaintainerInstitution: " ",
      productMaintainerNote: " ",
      productMaintenanceType: " ",
      productName: " ",
      productOperationMethod: " ",
      isTaskDone: 0,
    );
  }

  Future<void> _getUserRecords() async {
    var res = await UserDatabase.instance.readAllUsers();
    setState(() {
      _userRecords = res;
    });
  }

  Future<void> _getProductRecords() async {
    var res = await ProductDatabase.instance.readAllProduct();
    setState(() {
      _productRecords = res;
    });
  }

  void _getUserAndProductRecords() async {
    var res = await UserAndProductDatabase.instance.readAllUserAndProduct();
    setState(() {
      _userAndProductRecords = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Görev Atama Sayfası"),
        ),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 300,
                    color: Colors.blue[100],
                    child: ListView.builder(
                      itemCount: _userRecords.length,
                      itemBuilder: (_, i) => ListTile(
                          title: InkWell(
                        onTap: () {
                          mySelectedUser = _userRecords[i];
                          selectedUserId = _userRecords[i].userId ?? 0;
                          writeUserInputArea(mySelectedUser);
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _userRecords[i].userName ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _userRecords[i].userLastName ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 300,
                    color: Colors.red[100],
                    child: ListView.builder(
                      itemCount: _productRecords.length,
                      itemBuilder: (_, i) => ListTile(
                          title: InkWell(
                        onTap: () {
                          Product mySelectedTask = _productRecords[i];
                          selectedProduct = _productRecords[i];

                          writeTaskInputArea(mySelectedTask);
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white70),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _productRecords[i].productName ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white70),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      _productRecords[i].productMaintainer ??
                                          ""),
                                ),
                              )),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_circle_right_outlined),
                      Text(
                        "Görevliler(Seçiniz)",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_circle_right_outlined),
                      Text(
                        "Görevler(Seçiniz)",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: userTextController,
                decoration: InputDecoration(
                    enabled: false,
                    icon: Icon(Icons.person_add_alt),
                    hintText: " Listeden görevli seçiniz"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: taskTextController,
                decoration: InputDecoration(
                    enabled: false,
                    icon: Icon(Icons.task_alt_outlined),
                    hintText: " Listeden atanacak olan görevi seçiniz"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sendProductAndUsersDb(selectedUserId, selectedProduct);
                      alertDialog(context,
                          "${mySelectedUser.userName} -> ${selectedProduct.productName}");
                     // deleteFromList(selectedProduct);
                    });
                  },
                  child: Text("Atama yap")),
            )
          ],
        ));
  }

  alertDialog(BuildContext context, String message) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Görev Ataması Başarılı'),
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

  void writeUserInputArea(User user) {
    setState(() {
      String userName = user.userName ?? "";
      String userLastName = user.userLastName ?? "";

      userTextController.text = userName + " " + userLastName;
    });
  }

  void writeTaskInputArea(Product selectedTask) {
    setState(() {
      String taskName = selectedTask.productName ?? "";

      taskTextController.text = taskName;
    });
  }

  void sendProductAndUsersDb(int selectedUserId, Product selectedProduct) {
    setState(() {
      myUserAndProductObject.isTaskDone = 0;
      myUserAndProductObject.userId = selectedUserId;
      myUserAndProductObject.productId = selectedProduct.productId;
      myUserAndProductObject.productName = selectedProduct.productName;
      myUserAndProductObject.productMaintainer =
          selectedProduct.productMaintainer;
      myUserAndProductObject.productMaintainerInstitution =
          selectedProduct.productMaintainerInstitution;
      myUserAndProductObject.productMaintainerNote =
          selectedProduct.productMaintainerNote;
      myUserAndProductObject.productMaintenanceType =
          selectedProduct.productMaintenanceType;
      myUserAndProductObject.productOperationMethod =
          selectedProduct.productOperationMethod;
      myUserAndProductObject.productDoneTimes =
          selectedProduct.productDoneTimes;

      UserAndProductDatabase.instance.create(myUserAndProductObject);
    });
  }

  void deleteFromList(Product selectedProduct) {
    
      ProductDatabase.instance.delete(selectedProduct.productId ?? 0);
    
  }
}
