import 'package:diyanet_app/Database/user_database.dart';
import 'package:diyanet_app/Models/user_model.dart';
import 'package:diyanet_app/Screens/admin_home_page.dart';
import 'package:diyanet_app/Screens/register_page.dart';
import 'package:diyanet_app/Screens/user_home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageView> {
  final _formKey = GlobalKey<FormState>();
  var _isChecked = false;
  bool isUserExistt = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _loadUserEmailPassword();
    super.initState();
  }

  //handle remember me function
  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

//load email and password
  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email;
        passController.text = _password;
      }
    } catch (e) {
      print(e);
    }
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
            Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/diyanet_logo.png",
                )),
            const Text(
              'Giriş Yap',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Lütfen Uygun Bir E-Mail Giriniz",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'E-Mail Giriniz',
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
                        return 'Lütfen Parolanızı Giriniz';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Parolanızı Girin',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text("Beni Hatırla"),
                    contentPadding: EdgeInsets.zero,
                    value: _isChecked,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (newValue) {
                      _handleRemeberme(newValue ?? false);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          controlUser(
                              emailController.text, passController.text);
                              isUserExistt==false?alertDialog(context, "Kişi Bulunamadı."):"";
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Giriş',
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
                      const Text('Hesabınız yok mu?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPageView(),
                            ),
                          );
                        },
                        child: const Text('Hesap Oluştur'),
                      ),
                    ],
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
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bitti'),
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

  void controlUser(String email, String pass) async {
    List<User> allUsers;

    allUsers = await UserDatabase.instance.readAllUsers();

    for (var user in allUsers) {
      isUserExistt=true;
      if (user.userEmail == email && user.userPassword == pass) {
        setState(() {
          if (user.userEmail == "admin@diyanet.gov" &&
              user.userPassword == "admin") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AdminHomePage();
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserHomePage(
                user: user,
              );
            }));
          }
        });
      }
    }
  }
}
