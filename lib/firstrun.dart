import 'package:flutter/material.dart';

import 'connector.dart';

class Firstrun extends StatelessWidget {
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
                "After Register",
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,),
              ),

              // Buttons
              const SizedBox(height: 30),
              //  Button
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Connector(1)));
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
                  child: const Text('Next', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ));
  }
}
