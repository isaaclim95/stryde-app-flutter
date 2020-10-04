import 'package:flutter/material.dart';

import 'home.dart';

class Firstrun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Heading
          Text(
            "Instructions",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF409ded),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Margin
          const SizedBox(height: 30),
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Color(0xFF409ded),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Left Arrow Button
              Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 40,
              ),

              // Instructions Column
              Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Margin
                    const SizedBox(height: 30),
                    // Instructions Image
                    Image.asset(
                      'images/logo.png',
                      width: 200,
                    ),

                    const SizedBox(height: 15),
                    // Instructions Text
                    Text(
                      "These are some instructions",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),

              // Right Arrow Button
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 40,
              ),
            ]),
          ),

          // Margin
          const SizedBox(height: 30),
          // Register Button
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            onPressed: () {
              // Changing page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
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
              child: const Text('Start', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    ));
  }
}
