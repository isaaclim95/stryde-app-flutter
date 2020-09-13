import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strydeapp/services/constants.dart';


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

//  decoration: BoxDecoration(
//  borderRadius: new BorderRadius.circular(30.0),
//  ),
  Widget button1(title) {
    return Center(
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10.0,
          color: Colors.orange[300],
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              print(title + "tapped");
              setState(() {
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: 300,
              height: 300,
              child: Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  title,
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
  Size size = MediaQuery.of(context).size;
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
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36)
                          )
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      children: [
                        button1("Profile"),
                        button1("Exercises"),
                        button1("Record walking"),
                        button1("Profile"),
                      ],
                    ),
                  ),
                )
              ]
            ),
          ),
        )
    );
  }
}


