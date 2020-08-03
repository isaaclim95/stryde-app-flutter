import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firstrun.dart';
import 'welcome.dart';

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

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool _success;
    String _userEmail;

    return Scaffold(
      body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
            children: [
              // Heading
              Text(
                "Sign-Up",
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Margin
              const SizedBox(height: 30),
              // Name TextField
              Container(
                width: 300,
                child: TextField(
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

              // DropDownBoxes
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AgeDropdown(),
                  const SizedBox(width: 30),
                  GenderDropdown(),
                ],
              ),

              // TextFields
              Container(
                  width: 300,
                  child: Column(children: [
                    // Email TextField
                    const SizedBox(height: 15),
                    TextField(
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

                    // Password TextField
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
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

                    // Confirm Password TextField
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFf0f0f0),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ])),

              // History of Injury TextField
              const SizedBox(height: 15),
              Container(
                width: 300,
                child: TextField(
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

                  // Confirm Button
                  const SizedBox(width: 20),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      // Sign Up button is pressed, grab information here
                      print('Email: ' + _emailController.text);
                      print('Password: ' + _passwordController.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Firstrun()));
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
                          const Text('Sign Up', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          )
        ],
      ),
      ),
    );
  }
}
