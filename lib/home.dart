import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    ////////////////////////////////////////////////////////////////////////////
    // Methods here
    void getRows(String column) async {
      final dbRef = FirebaseDatabase.instance.reference().child("users");
      dbRef.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key,values) {
          print(values[column]);
        });
      });
    }
    getRows("email");
    ////////////////////////////////////////////////////////////////////////////

    return Material(
      child: Center(child: Text("Home")),

    );
  }
}