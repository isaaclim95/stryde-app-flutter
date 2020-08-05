import 'package:firebase_auth/firebase_auth.dart';
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

    String uid;

    Future fetchUid() async {
      uid = (await FirebaseAuth.instance.currentUser()).uid;
    }

    // Methods here
    Future getValueFromUser(String k) async {
      String userId = (await FirebaseAuth.instance.currentUser()).uid;
      final usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        print(values[k]);
      });
    }

    getValueFromUser("Height");
    fetchUid();


    ////////////////////////////////////////////////////////////////////////////

    return Material(
      child: Center(child: Text("Home")),


    );
  }
}