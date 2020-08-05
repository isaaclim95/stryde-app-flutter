import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String height, weight;

class HeightDropdown extends StatefulWidget {
  HeightDropdown({Key key}) : super(key: key);

  @override
  HeightDropdownState createState() => HeightDropdownState();
}

class HeightDropdownState extends State<HeightDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[];
    for (int i = 100; i <= 280; i++) {
      items.add(i.toString());
    }

    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: height,
                      hint: Text(
                        "Height",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          print(height);
                          height = newValue;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class WeightDropdown extends StatefulWidget {
  WeightDropdown({Key key}) : super(key: key);

  @override
  WeightDropdownState createState() => WeightDropdownState();
}

class WeightDropdownState extends State<WeightDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[];
    for (int i = 20; i <= 300; i++) {
      items.add(i.toString());
    }

    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: weight,
                      hint: Text(
                        "Weight",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          weight = newValue;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class AgeDropdown extends StatefulWidget {
  AgeDropdown({Key key}) : super(key: key);

  @override
  AgeDropdownState createState() => AgeDropdownState();
}

class AgeDropdownState extends State<AgeDropdown> {
  String age;

  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[];
    for (int i = 12; i <= 100; i++) {
      items.add(i.toString());
    }

    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: age,
                      hint: Text(
                        "Age",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          age = newValue;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class GenderDropdown extends StatefulWidget {
  GenderDropdown({Key key}) : super(key: key);

  @override
  GenderDropdownState createState() => GenderDropdownState();
}

class GenderDropdownState extends State<GenderDropdown> {
  String sex;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: sex,
                      hint: Text(
                        "Sex",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          sex = newValue;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class Profile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _historyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            // Heading
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF409ded),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Margin
            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name TextField
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFf0f0f0),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),

                  // DropDownBoxes Age and Gender
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AgeDropdown(),
                      const SizedBox(width: 30),
                      GenderDropdown(),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Email TextField
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFf0f0f0),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),

                  // History of Injury TextField
                  const SizedBox(height: 15),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _historyController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFf0f0f0),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(),
                        labelText: 'History of Injury',
                      ),
                    ),
                  ),



                  // DropDownBoxes Age and Gender
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeightDropdown(),
                      const SizedBox(width: 30),
                      WeightDropdown(),
                    ],
                  ),

                  const SizedBox(height: 15),
                  (height != null && weight != null ?
                    Text("BMI: " + (int.parse(weight)  / pow(int.parse(height) / 100, 2)).toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ) :
                    Text("BMI: Enter height and weight",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ),

                  // Buttons
                  const SizedBox(height: 30),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      // Sign Up button is pressed, grab information here
                      print('Email: ' + _emailController.text);
                      print('Password: ' + _passwordController.text);
                      /*_register();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Firstrun()));*/
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
                      child:
                          const Text('Confirm', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
