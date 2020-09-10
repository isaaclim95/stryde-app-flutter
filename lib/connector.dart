import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'training.dart';
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
    Training(),
    Record(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('Training'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            title: Text('Record'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF409ded),
        onTap: onItemTapped,
      ),
    );
  }

  ConnectorState(int selectedIndex){
    this.selectedIndex = selectedIndex;
  }
}
