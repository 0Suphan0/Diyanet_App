import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Database/user_database.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/admin_home_page.dart';
import 'package:diyanet_app/main.dart';
import 'package:flutter/material.dart';

class AssignedPageView extends StatefulWidget {
  AssignedPageView({Key? key}) : super(key: key);

  @override
  State<AssignedPageView> createState() => _AssignedPageViewState();
}

class _AssignedPageViewState extends State<AssignedPageView> {
  late List<UserAndProduct> _records;
  late List<User> _userRecords;
  String myResult = "";
  Color? green = Colors.green[200];
  Color? blue = Colors.blue[200];
  Color? resultColor;
  //static int myPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _records = [];
    _userRecords = [];
    _getRecords();
    _getUserRecords();

    //_getUser(myPosition);
  }

  String createMyName(int position) {
    for (var user in _userRecords) {
      if (user.userId == position) {
        return user.userName ?? "";
      }
    }

    return "";
  }

  // String result ="Yapılmadı";
  // String createMyTaskStatus(int position) {
  //   for (var item in _records) {
  //     if (item.userId == position) {
  //       int myValue = item.isTaskDone ??0;
  //       if(myValue==1){
  //         result ="Yapıldı";
  //       }
  //     }
  //   }

  //   return result;
  // }

  Future<void> _getRecords() async {
    var res = await UserAndProductDatabase.instance.readAllUserAndProduct();
    setState(() {
      _records = res;
    });
  }

  Future<void> _getUserRecords() async {
    var res = await UserDatabase.instance.readAllUsers();
    setState(() {
      _userRecords = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return AdminHomePage();
              }));
            },
            child: Icon(Icons.home)),
        title: Text('Atanan Görevler'),
      ),
      body: _records.length == 0
          ? Container(
              child: Center(child: Text("Atanmış Görev")),
            )
          : ListView.builder(
              itemCount: _records.length,
              itemBuilder: (_, int position) {
                identifyColor(position);
                return  Card(
                  color: resultColor,
                  shadowColor: Colors.black,
                  child: Column(
                    children: [
                      ListTile(
                          title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 16.0, right: 48, left: 48),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "ÜRÜN CİNSİ",
                                _records[position].productName ?? ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "TATBİKAT YÖNTEMİ",
                                _records[position].productOperationMethod ??
                                    ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "BAKIM/TATBİKAT SORUMLUSU",
                                _records[position].productMaintainer ?? ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "BAKIM TATBİKAT SORUMLU KURUM",
                                _records[position]
                                        .productMaintainerInstitution ??
                                    ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "PLANLANAN AYLAR",
                                _records[position].productDoneTimes ?? ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "BAKIM/TATBİKAT TİPİ",
                                _records[position].productMaintenanceType ??
                                    ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                _records[position].userId ?? 0,
                                "BAKIM NOTU",
                                _records[position].productMaintainerNote ?? ""),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 16.0, right: 48, left: 48),
                              child: buildCardItem(
                                  _records[position].userId ?? 0,
                                  "Görevli",
                                  createMyName(
                                      _records[position].userId ?? 0))),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 16.0, right: 48, left: 48),
                              child: buildCardItem(
                                  _records[position].userId ?? 0,
                                  "Görev Durumu",
                                  _records[position].isTaskDone == 1
                                      ? "Yapıldı"
                                      : "Yapılmadı")),
                          
                    
                        ],
                      )),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void identifyColor(int position) {
    if(_records[position].isTaskDone==1){
      resultColor=green;
    }else{
      resultColor=blue;
    }
  }


   showAlertDialog(BuildContext context, int position) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("İptal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Devam"),
      onPressed: () {
       setState(() {
         
         Navigator.pop(context);
       });
        
        
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Görev Tamamlandı Silmek Mi İstiyorsunuz ?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Container buildCardItem(int position, String textString, String dbText) {
    //myPosition=position;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.blue[50],
        ),
        padding: EdgeInsets.all(8),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Text(
              textString,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "$dbText",
              style: TextStyle(color: Colors.blue[700]),
            ),
          )
        ]));
  }

  // Future<void> _getUser(int id) async {
  //   User res =  await UserDatabase.instance.readUser(id) ;

  //   setState(() {
  //     myResult=res.userName??"";
  //   });

  // }

  // showAlertDialog(BuildContext context, int position) {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: Text("İptal"),
  //     onPressed: () {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => GelAllProductListPage()));
  //     },
  //   );
  //   Widget continueButton = TextButton(
  //     child: Text("Devam"),
  //     onPressed: () {
  //       ProductDatabase.instance.delete(position);
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => GelAllProductListPage()));
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Uyarı"),
  //     content: Text("Kaydı silmek istediğinizden emin misiniz ?"),
  //     actions: [
  //       continueButton,
  //       cancelButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
