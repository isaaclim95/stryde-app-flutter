import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  var _nameController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future setTextControllers() async  {
    print("setTextControllers()");
    try {
      String userId = (await _firebaseAuth.currentUser()).uid;
      final usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        _nameController.text = values['name'].toString();
      });
    } catch (e){
      print(e);
    }
  }


  @override
  void initState() {
    setTextControllers().then((value){
      print('setTextControllers done.');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            } else  {
              print("hi");
            }
          },
          child: Container(
//            color: Colors.red,
            padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Hi " + _nameController.text + ",",
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "How long have you exercised for today?",
                    style: GoogleFonts.openSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    children: [
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(-5),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                          //fillColor: Colors.green
                          ),
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        child: Text('minutes'),
//                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {},
                      )

                    ],
                  ),
                  SizedBox(height: 500)
                ]
              )
            ),
          ),
        )
    );
  }
}