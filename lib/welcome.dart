import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading
            Text(
              "Welcome to \nStryde",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF409ded),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Margin
            const SizedBox(height: 30),
            // Buttons
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
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: const Text('Login', style: TextStyle(fontSize: 20)),
              ),
            ),

            // Margin
            const SizedBox(height: 30),
            // Register Button
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
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: const Text('Sign-Up', style: TextStyle(fontSize: 20)),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ));
  }
}
