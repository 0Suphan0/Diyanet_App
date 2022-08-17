import 'package:diyanet_app/Database/user_and_product_bridge_database.dart';
import 'package:diyanet_app/Models/user_and_product_model.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/user_maintenance_form.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key, required this.user}) : super(key: key);

  User user;
  static int? myUpdatedIdValue;
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late List<UserAndProduct> _records;
  late List<String> allFields;
  
  
  //late UserAndProduct waitUserAndProduct;
  @override
  initState() {
    super.initState();
    _records = [];
    _getRecords();
    allFields = UserAndProductField.values;

    
  }

  Future<void> _getRecords() async {
    var res = await UserAndProductDatabase.instance.readAllUserAndProduct();

    setState(() {
      for (var i = 0; i < res.length; i++) {
       
        //eğer listenin i ninci elemanının idsi elimdeki idye eşit ise görev bu kullanıcınındır.
        if (res[i].userId == widget.user.userId &&res[i].isTaskDone==0 ) {
          _records.add(res[i]);
         
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                    "Hoşgeldiniz ${widget.user.userName} ${widget.user.userLastName}"),
              ),
            ),
            Center(child: Text("Görevleriniz"))
          ],
        ),
      ),
      body: _records.length == 0
          ? Container(child:Center(child: Text("Göreviniz Yok")))
          : ListView.builder(
              itemCount: _records.length,
              itemBuilder: (_, int position) {
                return Card(
                  color: Colors.blue[100],
                  shadowColor: Colors.black,
                  child: Column(
                    children: [
                      ListTile(
                          title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 16.0, right: 48, left: 48),
                            child: buildCardItem(position, "ÜRÜN CİNSİ",
                                _records[position].productName ?? ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                position,
                                "TATBİKAT YÖNTEMİ",
                                _records[position].productOperationMethod ??
                                    ""),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                position,
                                "BAKIM/TATBİKAT SORUMLUSU",
                                _records[position].productMaintainer ?? ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                position,
                                "BAKIM TATBİKAT SORUMLU KURUM",
                                _records[position]
                                        .productMaintainerInstitution ??
                                    ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(position, "PLANLANAN AYLAR",
                                _records[position].productDoneTimes ?? ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(
                                position,
                                "BAKIM/TATBİKAT TİPİ",
                                _records[position].productMaintenanceType ??
                                    ""),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: buildCardItem(position, "BAKIM NOTU",
                                _records[position].productMaintainerNote ?? ""),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                             buildButton(position, context)
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                );
              },
            ),
    );
  }

  ElevatedButton buildButton(int position, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            showAlertDialog(context,position);
            print(position);
            //UserHomePage.myUpdatedIdValue=_records[position].tableId;
           // UserAndProduct userAndProduct =
                // fillTheValues(waitUserAndProduct, position);
                // print("records ${_records[position].isTaskDone}");
                // print("userAndProduct ${userAndProduct.isTaskDone}");
                // print("records ${_records[position].productName}");
                // print("userAndProduct ${userAndProduct.productName}");

            // UserAndProductDatabase.instance
            //     .update(userAndProduct);
            // UserMaintenanceFormPage.userAndProduct=_records[position];
             //_records[position].isTaskDone=1;
            // print(position);
             
            //UserAndProductDatabase.instance.update(_records[position], UserHomePage.myUpdatedIdValue);
            
          });
        },
        child: Text("Yapıldı"));
  }

  Container buildCardItem(int position, String textString, String dbText) {
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
        //donanın bakım formu sayfası ve resim sayfası
        //buradaki userı form sayfasına statik gönder..
        //waitUserAndProduct.userIsDone=true;

        UserMaintenanceFormPage.user = widget.user;
        // UserMaintenanceFormPage.userAndProduct=waitUserAndProduct;

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return UserMaintenanceFormPage(UserAndProduct:_records[position]);
          
        })));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Görevi tamamlamak için donanım bakım formunu doldurunuz"),
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

  // UserAndProduct fillTheValues(waitUserAndProduct, position) {
  //   waitUserAndProduct.tableId=_records[position].tableId;
  //   waitUserAndProduct.productId = _records[position].productId;
  //   waitUserAndProduct.productName = _records[position].productName;
  //   waitUserAndProduct.productOperationMethod =
  //       _records[position].productOperationMethod;
  //   waitUserAndProduct.productMaintainer = _records[position].productMaintainer;
  //   waitUserAndProduct.productDoneTimes = _records[position].productDoneTimes;
  //   waitUserAndProduct.productMaintenanceType =
  //       _records[position].productMaintenanceType;
  //   waitUserAndProduct.productMaintainerNote =
  //       _records[position].productMaintainerNote;
  //   waitUserAndProduct.productMaintainerInstitution =
  //       _records[position].productMaintainerInstitution;
  //   waitUserAndProduct.userId = widget.user.userId;
  //   waitUserAndProduct.isTaskDone = 1;

  //   return waitUserAndProduct;
  // }

  // void getDoneTask(String? productName, String? productOperationMethod, String? productMaintainer, String? productMaintainerInstitution, String? productDoneTimes, String? productMaintenanceType, String? productMaintainerNote) {
  //   waitUserAndProduct.productName=productName;
  //   waitUserAndProduct.productOperationMethod=productOperationMethod;
  //   waitUserAndProduct.productMaintainer=productMaintainerInstitution;
  //   waitUserAndProduct.productDoneTimes=productDoneTimes;
  //   waitUserAndProduct.productMaintenanceType=productMaintenanceType;
  //   waitUserAndProduct.productMaintainerNote=productMaintainerNote;
  //   waitUserAndProduct.userId=widget.user.userId;
  //   waitUserAndProduct.userIsDone=true;

  // }
}
