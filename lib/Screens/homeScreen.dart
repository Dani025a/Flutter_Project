import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Screens/addScreen.dart';
import 'package:firstapp/Screens/editScreen.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _title = 'Home';
  final Stream<QuerySnapshot> studentRecords =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    CollectionReference delUser =
        FirebaseFirestore.instance.collection('users');
    Future<void> _delete(id) {
      return delUser
          .doc(id)
          .delete()
          .then((value) => print('User Deleted'))
          .catchError((_) => print('Something Error In Deleted User'));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: studentRecords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List firebaseData = [];
          snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
            Map store = documentSnapshot.data() as Map<String, dynamic>;
            firebaseData.add(store);
            store['id'] = documentSnapshot.id;
          }).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(_title),
            ),
            body: Container(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    1: FixedColumnWidth(150),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            color: Colors.greenAccent,
                            child: Center(
                              child: Text(
                                '\nUsers\n',
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.greenAccent,
                            child: Center(
                              child: Text(
                                '\nEdit\n',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < firebaseData.length; i++) ...[
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              child: Center(
                                child: Text("\nName: " +
                                    firebaseData[i]['name'] +
                                    "\nEmail: " +
                                    firebaseData[i]['email'] +
                                    "\nNumber: " +
                                    firebaseData[i]['number'] +
                                    "\nAddress: " +
                                    firebaseData[i]['address'] +
                                    "\n"),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                            docID: firebaseData[i]['id']),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _delete(firebaseData[i]['id']);
                                    //print(firebaseData);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddScreen()),
                  );
                }),
          );
        });
  }
}
