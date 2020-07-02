import 'package:flutter/material.dart';

import 'profile.dart';
import 'training.dart';
import 'record.dart';


class Connector extends StatefulWidget {
  Connector({Key key}) : super(key: key);

  @override
  ConnectorState createState() => ConnectorState();


  Widget build(BuildContext context) {
    return Connector();
  }
}

class ConnectorState extends State<Connector> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
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
        items: const <BottomNavigationBarItem>[
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
}

/*class Profile extends StatelessWidget {

}*/
