import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          /*Image.asset(
            'images/logo.png',
            height: 200,
          )*/
          // Welcome Text
          Text(
            "Welcome to Stryde",
            style: TextStyle(
                color: Color(0xFF409ded),
                fontSize: 30,
                fontWeight: FontWeight.bold,),
          ),

          // Buttons
          const SizedBox(height: 30),
          // Login Button
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Color(0xFF409ded),
              ),
              width: 130,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: const Text('Log In', style: TextStyle(fontSize: 20)),
            ),
          ),

          // Register Button
          const SizedBox(height: 20),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: Color(0xFF409ded),
              ),
              width: 130,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: const Text('Register', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    ));
  }
}
