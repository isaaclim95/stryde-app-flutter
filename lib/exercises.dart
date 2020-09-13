import 'package:flutter/material.dart';

Widget exercise;

//void changeExercise(){
//  setState(() {
//    print(exercise);
//    exercise = Text("TEST");
//    //print(exercise);
//  });
//}

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
            ),
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