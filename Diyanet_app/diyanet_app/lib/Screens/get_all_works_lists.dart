import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/static_product_database.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:diyanet_app/Screens/add_product_page.dart';
import 'package:diyanet_app/Screens/admin_home_page.dart';
import 'package:diyanet_app/Screens/update_product_page.dart';
import 'package:flutter/material.dart';

class GelAllProductListPage extends StatefulWidget {
  @override
  _GelAllProductListPage createState() => _GelAllProductListPage();
}

class _GelAllProductListPage extends State<GelAllProductListPage> {
  late List<Product> _records;
  late List<String> allFields;
  //late List<StaticProduct> _recordsStatic;

 
  @override
  initState() {
    super.initState();
    _records = [];
   // _recordsStatic = [];
    _getRecords();
   // _getRecordsStatic();
    allFields = ProductFields.values;
    
  }

  Future<void> _getRecords() async {
    var res = await ProductDatabase.instance.readAllProduct();
    setState(() {
      _records = res;
    });
  }

  // Future<void> _getRecordsStatic() async {
  //   var res = await StaticProductDatabase.instance.readAllProduct();
  //   setState(() {
  //     _recordsStatic = res;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return AdminHomePage();
          }));
        }, child: Icon(Icons.home)),
        title: Text('Bakım/Tatbikat Listesi'),
      ),
      body: _records.length == 0
          ? Container(child: Center(child: Text("Eklenmiş Görev Yok")),)
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
                            padding: const EdgeInsets.only(top: 4.0,bottom:16.0,right: 48,left: 48),
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
                              ElevatedButton(onPressed: (){

                                  int? idValue=_records[position].productId;

                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                // UpdateProductPage.mySendingProductStatic=_recordsStatic[position];
                                 UpdateProductPage.mySendingProduct=_records[position];
                                 UpdateProductPage.mySendingIdValue=idValue;
                                 return UpdateProductPage();
                                  
                                 
                                }));
                              }, child: Text("Güncelle")),
                              ElevatedButton(onPressed: (){
                                showAlertDialog(context, _records[position].productId??0);
                              }, child: Text("Sil")),
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

  showAlertDialog(BuildContext context,int position) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("İptal"),
    onPressed:  () {
      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GelAllProductListPage()));
    },
  );
  Widget continueButton = TextButton(
    child: Text("Devam"),
    onPressed:  () {
      ProductDatabase.instance.delete(position);
     //StaticProductDatabase.instance.delete(position);
      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GelAllProductListPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Uyarı"),
    content: Text("Kaydı silmek istediğinizden emin misiniz ?"),
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
}
