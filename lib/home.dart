import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    _nameController.text = "Name Here";

    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // margin
              const SizedBox(height: 60),

              // Heading
              Text(
                "Home",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Margin
              const SizedBox(height: 10),

              // Introduction Text
              Container(
                width: 300,
                child: Row(
                  children: [
                    Text(
                      "Hello ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                        width: 180,
                        child: TextField(
                          readOnly: true,
                          controller: _nameController,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )
                    )
                ])
              ),
              Container(
                width: 300,
                child: Text(
                  "Using this app will allow you to better understand your posture and how to correct it. Goodluck!",
                  style: TextStyle(fontSize: 18),
                )
              ),

              // margin
              const SizedBox(height: 30),

              // Health statistics heading
              Container(
                width: 275,
                child: Text(
                  "Suggested Exercises:",
                  style: TextStyle(
                    color: Color(0xFF409ded),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // margin
              const SizedBox(height: 10),

              // Image example 1
              Image(
                image: AssetImage('images/situp.png'),
                width: 200,
              ),

              // margin
              const SizedBox(height: 5),

              // Exercise text 1
              Text("Situps"),

              // margin
              const SizedBox(height: 10),

              // Image example 2
              Image(
                image: AssetImage('images/tpushup.png'),
                width: 200,
              ),

              // margin
              const SizedBox(height: 5),

              // Exercise text 2
              Text("T Push-up"),

            ],
          )
        )
      )


    );
  }
}