import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/globals.dart' as globals;

Widget exercise;

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
      String userId = _firebaseAuth.currentUser.uid;
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
//    exercise = DailyExercise(nameText: _nameController.text, changeExerciseFunc: changeExercise);
    super.initState();
  }

  void changeExercise(){
    setState(() {
      print(exercise);
      exercise = Text("TEST");
      //print(exercise);
    });
  }

  @override
  Widget build(BuildContext context) {
//    exercise = DailyExercise(nameText: "name", changeExerciseFunc: changeExercise);
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
//                  exercise,
                  SizedBox(height: 30),
                  DailyWeight(),
                  SizedBox(height: 500)
                ]
              )
            ),
          ),
        )
    );
  }
}

class DailyExercise extends StatefulWidget {
  final String nameText;
  final Function changeExerciseFunc;

  const DailyExercise({Key key, @required this.nameText, @required this.changeExerciseFunc}): super(key: key);

  @override
  _DailyExerciseState createState() {
    return _DailyExerciseState();
  }

}

class _DailyExerciseState extends State<DailyExercise>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Hi " + globals.name + ",",
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
              onPressed: () {
                widget.changeExerciseFunc();
              },
            )

          ],
        ),
      ],
    );
  }
}

class DailyWeight extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "What is your weight today?",
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
              child: Text('weight'),
//                        color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              onPressed: () {

              },
            )

          ],
        ),
      ],
    );
  }
}