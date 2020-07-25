import 'package:flutter/material.dart';
import 'package:strydeapp/welcome.dart';
import 'connector.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Heading
          Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF409ded),
              fontSize: 48,
              fontWeight: FontWeight.bold,),
          ),

          // Margin
          const SizedBox(height: 30),
          // TextFields
          Container(
              width: 300,
              child: Column(children: [
                // Email TextField
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
              // Back Button
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Welcome()));
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
                  child: const Text('Back', style: TextStyle(fontSize: 20)),
                ),
              ),

              // Login Button
              const SizedBox(width: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connector(0)));
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
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
