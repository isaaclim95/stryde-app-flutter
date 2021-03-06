import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:statusbar/statusbar.dart';
import 'package:strydeapp/profile.dart';
import 'package:strydeapp/record.dart';
import 'package:strydeapp/services/constants.dart';
import 'package:strydeapp/services/firebase_service_model.dart';
import 'package:strydeapp/welcome.dart';
import 'services/globals.dart' as globals;
import 'exercises.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var _nameController = TextEditingController();
  FocusNode exerciseFocus = FocusNode();
  bool done = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future setTextControllers() async {
    print("setTextControllers()");
    try {
      String userId = _firebaseAuth.currentUser.uid;
      final usersReference =
          FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        _nameController.text = values['name'].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  Widget button1(title, route, icon) {
    return Center(
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10.0,
          //color: Color(0xffe0e0e0),
          color: kPrimaryColor,
          child: InkWell(
            splashColor: kPrimaryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              print(title + "tapped");
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => route),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: 160,
              height: 160,
              child: Column(children: [
                Align(
                    alignment: Alignment(0, -0.9),
                    child: Text(
                      title,
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Icon(
                      icon,
                      size: 60,
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget button2(title, icon) {
    return Center(
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10.0,
          //color: Color(0xffe0e0e0),
          color: kPrimaryColor,
          child: InkWell(
            splashColor: kPrimaryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              print(title + "tapped");
              setState(() {
                var as = AuthenticationService();
                as.signOut();
                // Showing toast after completion
                Fluttertoast.showToast(
                    msg: "Signed out",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: 160,
              height: 160,
              child: Column(children: [
                Align(
                    alignment: Alignment(0, -0.9),
                    child: Text(
                      title,
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Icon(
                      icon,
                      size: 60,
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////
  Future<void> alertBox(title, response) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: GoogleFonts.openSans(
                  fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          content: Text(response,
              style: GoogleFonts.openSans(
                  fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          actions: <Widget>[
            RaisedButton(
              color: kPrimaryColor,
              child: Text('Close',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget dailyExercise() {
    var _exerciseController = TextEditingController();

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        //color: Color(0xffe0e0e0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: 350,
          child: Column(
            children: [
              Text("How long have you exercised for today?",
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                      focusNode: exerciseFocus,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(-5),
                        filled: true,
                        fillColor: Color(0xFFf0f0f0),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: _exerciseController,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    //child: Text('Minutes'),
                    color: kPrimaryColor,
                    child: Text('Minutes',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    //                        color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      setState(() {
                        exerciseFocus.unfocus();
                        String response;
                        String title;
                        if (int.parse(globals.age) < 18) {
                          if (int.parse(_exerciseController.text) < 60) {
                            title = "Not enough exercise";
                            response =
                                "According to Australia's Department of Health you should be doing 60 minutes or more exercise daily";
                          } else {
                            title = "Great job";
                            response =
                                "You've met your daily recommended exercise";
                          }
                        } else if (int.parse(globals.age) < 65) {
                          if (int.parse(_exerciseController.text) < 10) {
                            title = "Not enough exercise";
                            response =
                                "According to Australia's Department of Health you should be doing 10 minutes or more exercise daily";
                          } else {
                            title = "Great job";
                            response =
                                "You've met your daily recommended exercise";
                          }
                        } else {
                          if (int.parse(_exerciseController.text) < 30) {
                            title = "Not enough exercise";
                            response =
                                "According to Australia's Department of Health you should be doing 30 minutes or more exercise daily";
                          } else {
                            title = "Great job";
                            response =
                                "You've met your daily recommended exercise";
                          }
                        }
                        alertBox(title, response);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  /////////////////////////////////////////
  AuthenticationService as = AuthenticationService();

  Widget dailyWeight() {
    var _weightController = TextEditingController();

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        //color: Color(0xffe0e0e0),
        child: Container(
            padding: EdgeInsets.all(10.0),
            width: 350,
            child: Column(
              children: [
                Text("What is your current weight?",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(-5),
                          filled: true,
                          fillColor: Color(0xFFf0f0f0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        controller: _weightController,
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                      //child: Text('Kilograms'),
                      color: kPrimaryColor,
                      child: Text('Kilograms',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
//                        color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      onPressed: () {
                        setState(() {
                          as.putWeight(double.parse(_weightController.text));
                          globals.weight = _weightController.text;
                          globals.weight_data.add({
                            'weight': double.parse(_weightController.text),
                            'date': DateTime.now()
                          });
                          // Showing toast after completion
                          Fluttertoast.showToast(
                              msg: "Weight saved.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                    ),
                  ],
                ),
              ],
            )));
  }

  @override
  void initState() {
    setTextControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.color(kPrimaryColor);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Column(children: [
              SizedBox(height: 30),
              Text(
                "Hi " + globals.name,
                style: GoogleFonts.openSans(
                    fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              dailyExercise(),
              SizedBox(height: 5),
              dailyWeight(),
              Column(
                children: <Widget>[
                  GridView(
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 3/2.8,
                    ),
                    children: [
                      button1("Profile", Profile(), Icons.account_circle),
                      button1("Exercises", Exercises(), Icons.fitness_center),
                      button1("Record", Record(), Icons.photo_camera),
                      button2("Sign out", Icons.exit_to_app),
                    ],
                  )
                ],
              )
            ]),
          ),
        ));
  }
}
