import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'signUpScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 18),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: loginEmail,
                    validator: (loginEmail) {
                      if (loginEmail == null || loginEmail.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 18),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: loginPassword,
                    obscureText: true,
                    validator: (loginPassword) {
                      if (loginPassword == null || loginPassword.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: loginEmail.text,
                              password: loginPassword.text,
                            )
                            .then((value) => {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false,
                                  )
                                })
                            .onError((error, stackTrace) => {
                                  Fluttertoast.showToast(
                                      msg: "Wrong email or password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0),
                                });

                        print("Email: " + loginEmail.text);
                        print("Password: " + loginPassword.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Don’t have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }
}
