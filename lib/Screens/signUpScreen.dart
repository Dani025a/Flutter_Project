import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  static const String _title = 'Sign Up';

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
                      'Sign Up',
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
                    controller: signUpEmail,
                    validator: (signUpEmail) {
                      if (signUpEmail == null || signUpEmail.isEmpty) {
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
                    controller: signUpPassword,
                    obscureText: true,
                    validator: (signUpPassword) {
                      if (signUpPassword == null || signUpPassword.isEmpty) {
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
                      child: const Text('Sign Up'),
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: signUpEmail.text,
                              password: signUpPassword.text,
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
                                      msg: "Could not sign you up",
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0),
                                });

                        print("Email: " + signUpEmail.text);
                        print("Password: " + signUpPassword.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does have account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
