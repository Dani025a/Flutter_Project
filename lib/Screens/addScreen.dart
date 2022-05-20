import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:firstapp/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  static const String _title = 'User';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Form(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 15,
              ),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 18),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Fill Name';
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
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 18),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Fill Email';
                  }
                  if (!val.contains('@')) {
                    return 'Please Enter Valid Email';
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
                keyboardType: TextInputType.number,
                controller: number,
                decoration: const InputDecoration(
                  labelText: 'Number',
                  labelStyle: TextStyle(fontSize: 18),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Fill Number';
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
                controller: address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(fontSize: 18),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Fill Address';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addUser(
                        name: name.text,
                        email: email.text,
                        number: number.text,
                        address: address.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addUser({
  required String name,
  required String email,
  required String number,
  required String address,
}) async {
  String id;

  final docUser = FirebaseFirestore.instance.collection('users').doc();
  id = docUser.id;

  Map<String, dynamic> data = <String, dynamic>{
    'id': id,
    'name': name,
    'email': email,
    'number': number,
    'address': address,
  };
  FirebaseFirestore.instance.collection('users').add(data);
}
