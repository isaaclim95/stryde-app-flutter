import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:strydeapp/services/constants.dart';
import 'package:strydeapp/services/firebase_service_model.dart';
import 'graph.dart';
import 'services/globals.dart' as globals;
import 'dart:math';

String height, weight, age, sex;
bool dataSet;

var _heightController = TextEditingController();
var _weightController = TextEditingController();
var _nameController = TextEditingController();
var _historyController = TextEditingController();
var _bmiController = TextEditingController();
var _ageController = TextEditingController();

Future<void> getAndSetGlobalData() async {
  final AuthenticationService authenticationService = AuthenticationService();
  authenticationService.getData();
}

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  /// Sets all text controllers with the values from globals.dart
  void setTextControllers() {
    print("setTextControllers()");

    _heightController.text = globals.height;
    _weightController.text = globals.weight;
    _nameController.text = globals.name;
    _ageController.text = globals.age;
    _historyController.text = globals.injury_history;

    _bmiController.text = (double.parse(globals.weight) /
            pow(double.parse(globals.height) / 100, 2))
        .toStringAsFixed(3);
  }

  /// Saves the information from the profile page into the database
  /// and updates the global variables to match
  ///
  /// Executed when "Save" button is clicked
  Future saveProfile() async {
    print("saveProfile()");

    // Updating profile information in database
    String userId = FirebaseAuth.instance.currentUser.uid;
    final usersReference =
        FirebaseDatabase.instance.reference().child("users").child(userId);
    usersReference.update({'height': _heightController.text});
    usersReference.update({'weight': _weightController.text});
    usersReference.update({'age': _ageController.text});
    usersReference.update({'injury_history': _historyController.text});

    // Updating local profile information
    globals.height = _heightController.text;
    globals.weight = _weightController.text;
    globals.age = _ageController.text;
    globals.injury_history = _historyController.text;

    // Update bmi
    _bmiController.text = (double.parse(globals.weight) /
            pow(double.parse(globals.height) / 100, 2))
        .toStringAsFixed(3);

    // Un-focusing all fields
    FocusScope.of(context).unfocus();
    new TextEditingController().clear();

    // Showing toast after completion
    Fluttertoast.showToast(
        msg: "Profile saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  @override
  void initState() {
    final AuthenticationService authenticationService = AuthenticationService();
    authenticationService.getData().then((value) {
      setState(() {
      });
      print("hi");
    });
    setTextControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: Container(
          padding:
              EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Text("Profile",
                                      style: GoogleFonts.openSans(
                                          color: kPrimaryColor,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700)),
                                  Spacer(),
                                  Container(
                                    height: 50,
                                    width: 70,
                                    child: RawMaterialButton(
                                      onPressed: saveProfile,
                                      elevation: 2.0,
                                      fillColor: kPrimaryColor,
                                      padding: EdgeInsets.all(15.0),
                                      shape: CircleBorder(),
                                      child: Text("Save"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.account_circle,
                                size: 60,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 15.0),
                              child: IntrinsicWidth(
                                child: TextField(
                                    decoration: null,
                                    style: GoogleFonts.openSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                    enabled: true,
                                    controller: _nameController),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 15.0),
                              child: IntrinsicWidth(
                                child: TextField(
                                    decoration: null,
                                    style: GoogleFonts.openSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                    enabled: true,
                                    controller: _ageController),
                              ),
                            ),
                            SizedBox(width: 50),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        // FIRST ROW
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90,
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(100.0)),
                                  color: Colors.grey[300]),
                              padding: new EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Weight"),
                                  SizedBox(height: 5.0),
                                  IntrinsicWidth(
                                    child: TextField(
                                        decoration: null,
                                        enabled: false,
                                        controller: _weightController),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
                                  color: Colors.grey[300]),
                              padding: new EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Height"),
                                  SizedBox(height: 5.0),
                                  IntrinsicWidth(
                                    child: TextField(
                                        decoration: null,
                                        enabled: true,
                                        controller: _heightController),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
                                  color: Colors.grey[300]),
                              padding: new EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("BMI"),
                                  SizedBox(height: 5.0),
                                  IntrinsicWidth(
                                    child: TextField(
                                        decoration: null,
                                        enabled: false,
                                        controller: _bmiController),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: TextFormField(
                        controller: _historyController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFF0F0F0),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
                          border: OutlineInputBorder(),
                          labelText: 'History of Injury',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Weight Graph"),
                    Container(
                      width: 300,
                      height: 200,
                      child: PointsLineChart.weightGraph(),
                    )
                  ])
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
