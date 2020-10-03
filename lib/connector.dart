import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:strydeapp/services/constants.dart';

import 'home.dart';
import 'profile.dart';
import 'exercises.dart';
import 'record.dart';


class Connector extends StatefulWidget {
  int selectedIndex = 0;

  @override
  ConnectorState createState() => ConnectorState(selectedIndex);


  Widget build(BuildContext context) {
    return Connector(selectedIndex);
  }

  Connector(int selectedIndex){
    this.selectedIndex = selectedIndex;
  }
}

class ConnectorState extends State<Connector> {
  int selectedIndex;

  final List<Widget> pages = <Widget>[
    Home(),
    Profile(),
    Exercises(),
    Record(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    StatusBar.color(kPrimaryColor);
    return Scaffold(
      //
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: kPrimaryColor
      // ),
      body: pages.elementAt(selectedIndex),
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.account_circle),
//            title: Text('Profile'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.fitness_center),
//            title: Text('Training'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.photo_camera),
//            title: Text('Record'),
//          ),
//        ],
//        currentIndex: selectedIndex,
//        selectedItemColor: Colors.white,
//        backgroundColor: Color(0xFF409ded),
//        onTap: onItemTapped,
//      ),
    );
  }

  ConnectorState(int selectedIndex){
    this.selectedIndex = selectedIndex;
  }
}
