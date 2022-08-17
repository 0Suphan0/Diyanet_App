import 'package:diyanet_app/Database/user_database.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  

  @override
  State<RegisterPageView> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageView> {
//global key
  final _formKey = GlobalKey<FormState>();
//beni hatırla
  var rememberValue = false;
//tüm kullanıcılar için liste
  late List<User> allUser;
//eklenecek kullanıcı
  late User userWillBeAdded =
      User(userName: " ", userEmail: "", userLastName: "", userPassword: "");

// controllerlar...
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allUser = [];
    getAllFromDb();
  }

  void getAllFromDb()async{
    allUser=await UserDatabase.instance.readAllUsers();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kaydol',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bu alan boş geçilemez.';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Adınız',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bu alan boş geçilemez.';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Soy adınız',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: gmailController,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Uygun bir e-mail giriniz.",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen şifrenizi belirleyiniz.';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          User userWillBeAdded2 =
                              fillToFields(userWillBeAdded);
                          bool result = isAlreadyExist(userWillBeAdded2);
                          if (result) {
                            alertDialog(context, "Bu E-mail kayıtlı, lütfen giriş yapmayı deneyiniz.");
                          } else {
                            UserDatabase.instance.create(userWillBeAdded2);
                            alertDialog(context, "Kayıt Başarılı");
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Kaydol',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Zaten kayıtlı mısınız ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPageView(),
                            ),
                          );
                        },
                        child: const Text('Giriş'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "T.C Cumhurbaşkanlığı Diyanet İşleri Başkanlığı",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  alertDialog(BuildContext context, String message) async {
    return await showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bitti'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return RegisterPageView();
                  }));
                },
              ),
            ],
          );
        });
  }

  User fillToFields(User userWillBeAdded) {
    userWillBeAdded.userName = nameController.text;
    userWillBeAdded.userLastName = lastNameController.text;
    userWillBeAdded.userEmail = gmailController.text;
    userWillBeAdded.userPassword = passController.text;

    return userWillBeAdded;
  }

 

  bool isAlreadyExist(User userWillBeAdded2) {
  
  
    for (var user in allUser) {
      if (user.userEmail == userWillBeAdded2.userEmail) {
        return true;
      }
    }
    return false;
  }
}
