import 'package:flutter/material.dart';
import 'register.dart';
import 'connector.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo Image
          const SizedBox(height: 80),
          Image.asset(
            'images/logo.png',
            height: 200,
          ),

          // TextFields
          Container(
              width: 300,
              child: Column(children: [
                // Email TextField
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Color(0xFFf0f0f0),
                    filled: true,
                    contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),

                // Password TextField
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFf0f0f0),
                    filled: true,
                    contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ])),

          // Buttons
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Register Button
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
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

              // Login Button
              const SizedBox(width: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connector()));
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
                  child: const Text('Login', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
