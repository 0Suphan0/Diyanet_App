import 'package:diyanet_app/Database/product_database.dart';
import 'package:diyanet_app/Database/static_product_database.dart';
import 'package:diyanet_app/Models/product_model.dart';
import 'package:diyanet_app/Models/static_table_product_model.dart';
import 'package:diyanet_app/Screens/get_all_works_lists.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({Key? key}) : super(key: key);

  static String myValue = "Bakım";
  static String monthValue = "";
  //static StaticProduct? mySendingProductStatic;
  static Product? mySendingProduct;
  static int? mySendingIdValue;

  @override
  State<UpdateProductPage> createState() => _UpdateProductPage();
}

class _UpdateProductPage extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //Product Instance
  Product productWillbeAdded = Product(
      productName: "",
      productOperationMethod: "",
      productMaintainer: " ",
      productMaintainerInstitution: "",
      productDoneTimes: "",
      productMaintainerNote: "",
      productMaintenanceType: "");

  //  StaticProduct myProductWillbeAddedStatic = StaticProduct(
  //     productName: "",
  //     productOperationMethod: "",
  //     productMaintainer: " ",
  //     productMaintainerInstitution: "",
  //     productDoneTimes: "",
  //     productMaintainerNote: "",
  //     productMaintenanceType: "");    

  //controllerlar
  TextEditingController productNameCon = TextEditingController(
      text: UpdateProductPage.mySendingProduct?.productName);
  TextEditingController productOperationMethodCon = TextEditingController(
      text: UpdateProductPage.mySendingProduct?.productOperationMethod);
  TextEditingController productMaintainerCon = TextEditingController(
      text: UpdateProductPage.mySendingProduct?.productMaintainer);
  TextEditingController productMaintainerInstitutionCon = TextEditingController(
      text: UpdateProductPage.mySendingProduct?.productMaintainerInstitution);
  TextEditingController productNoteCon = TextEditingController(
      text: UpdateProductPage.mySendingProduct?.productMaintainerNote);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Ürün/Bakım Tatbikat Güncelle"),
        ),
        body: Form(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: productNameCon,
                decoration: InputDecoration(
                    hintText: "Ürün Cinsini Giriniz.", labelText: "Ürün Cinsi"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: productOperationMethodCon,
                decoration: InputDecoration(
                    hintText: "Yoksa Boş bırakın",
                    labelText: "Varsa Tatbikat Yöntemi"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: productMaintainerCon,
                decoration: InputDecoration(
                    hintText: "Bakım/Tatbikat Sorumlusu",
                    labelText: "Bakım/Tatbikat Sorumlusu"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: productMaintainerInstitutionCon,
                decoration: InputDecoration(
                    hintText: "Bakım/Tatbikat Gerçekleştiren Kurum",
                    labelText: "Bakım/Tatbikat Gerçekleştiren Kurum"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: productNoteCon,
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Bakım/Tatbikat Notu",
                    labelText: "Bakım/Tatbikat Notu"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text("Bakım Tipini Seçiniz"),
                  ),
                  DropDownCustom()
                ],
              ),
              SizedBox(height: 30),
              Center(child: Text("İşlem Yapılacak Ayları Seçiniz:")),
              SizedBox(height: 20),
              MonthCompenent(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Product productWillBeAdded2 =
                        addToDataBaseProduct(productWillbeAdded);

                    // StaticProduct productWillBeAdded2Static =
                    //     addToDataBaseProductStatic(myProductWillbeAddedStatic);    

                    ProductDatabase.instance.update(productWillBeAdded2,
                        UpdateProductPage.mySendingIdValue);

                    // StaticProductDatabase.instance.update(productWillBeAdded2Static,
                    //     UpdateProductPage.mySendingIdValue);    
                    alertDialog(context);
                  });
                },
                child: Text("Güncelle"),
              )
            ],
          ),
        )));
  }

   alertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bitti'),
            content: Text('Güncelleme Başarılı'),
            actions: <Widget>[
              FlatButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GelAllProductListPage()));
                },
              ),
            ],
          );
        });
  }
  

  Product addToDataBaseProduct(Product productWillbeAdded) {
    productWillbeAdded.productId = UpdateProductPage.mySendingIdValue;
    productWillbeAdded.productName = productNameCon.text;
    productWillbeAdded.productOperationMethod = productOperationMethodCon.text;
    productWillbeAdded.productMaintainer = productMaintainerCon.text;
    productWillbeAdded.productMaintainerInstitution =
        productMaintainerInstitutionCon.text;
    productWillbeAdded.productMaintainerNote = productNoteCon.text;
    productWillbeAdded.productMaintenanceType = UpdateProductPage.myValue;
    productWillbeAdded.productDoneTimes = UpdateProductPage.monthValue;

    return productWillbeAdded;
  }

  //  StaticProduct addToDataBaseProductStatic(StaticProduct productWillbeAdded) {
  //   productWillbeAdded.productId = UpdateProductPage.mySendingIdValue;
  //   productWillbeAdded.productName = productNameCon.text;
  //   productWillbeAdded.productOperationMethod = productOperationMethodCon.text;
  //   productWillbeAdded.productMaintainer = productMaintainerCon.text;
  //   productWillbeAdded.productMaintainerInstitution =
  //       productMaintainerInstitutionCon.text;
  //   productWillbeAdded.productMaintainerNote = productNoteCon.text;
  //   productWillbeAdded.productMaintenanceType = UpdateProductPage.myValue;
  //   productWillbeAdded.productDoneTimes = UpdateProductPage.monthValue;

  //   return productWillbeAdded;
  // }
}

class DropDownCustom extends StatefulWidget {
  const DropDownCustom({Key? key}) : super(key: key);

  @override
  State<DropDownCustom> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<DropDownCustom> {
  String dropdownValue = 'Bakım';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if(newValue==null){
            newValue="Bakım";
          }else{
            UpdateProductPage.myValue = dropdownValue;  
          }
          
        });
      },
      items: <String>['Bakım', 'Tatbikat', 'Bakım Anında Tatbikat']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MonthCompenent extends StatefulWidget {
  MonthCompenent({Key? key}) : super(key: key);
  static String selectedString = "";
  @override
  State<MonthCompenent> createState() => _TestPageState();
}

class _TestPageState extends State<MonthCompenent> {
  static const int _count = 12;
  final List<bool> _checks = List.generate(_count, (_) => false);

  List<String> months = [
    "OCAK",
    "ŞUBAT",
    "MART",
    "NİSAN",
    "MAYIS",
    "HAZİRAN",
    "TEMMUZ",
    "AĞUSTOS",
    "EYLÜL",
    "EKİM",
    "KASIM",
    "ARALIK"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateProductPage.monthValue=" ";
  }

  @override
  Widget build(BuildContext context) {
     
    return Container(
      width: 375,
      height: 150,
      child: GridView.builder(
        itemCount: _count,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (_, i) {
          return Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          months[i],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  color: Colors.blue[(i * 100) % 900]),
              Align(
                alignment: Alignment.topCenter,
                child: Checkbox(
                  value: _checks[i],
                  onChanged: (newValue) {
                    setState(() {
                      _checks[i] = newValue ?? false;
                      if (_checks[i]) {
                        print(months[i]);
                       
                        UpdateProductPage.monthValue += months[i] + ",";
                      }
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
