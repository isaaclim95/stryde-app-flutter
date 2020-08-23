import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strydeapp/services/firebase_service_model.dart';

String height, weight, age, sex;

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  final AuthenticationService _authenticationService = AuthenticationService();

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void saveProfile()  {
    print("save profile");
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
          padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: CustomScrollView(
              slivers: [
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
                                padding: const EdgeInsets.only(left:5.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                          "Profile",
                                          style: GoogleFonts.openSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700
                                          )
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 50,
                                        width: 70,
                                        child: RawMaterialButton(
                                          onPressed: saveProfile,
                                          elevation: 2.0,
                                          fillColor: Colors.lightBlue[200],
                                          padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                          child: Text(
                                              "Save"
                                          ),
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
                                  padding: const EdgeInsets.only(left: 16.0, bottom: 15.0),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                        decoration: null,
                                        style: GoogleFonts.openSans(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600
                                        ),
                                        enabled: true,
                                        controller: _nameController
                                    ),
                                  ),
                                ),
                                SizedBox(width: 50),
                                IntrinsicWidth(
                                  child: TextField(
                                      decoration: null,
                                      enabled: true,
                                      controller: _ageController
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 20
                      ),
                      Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                // FIRST ROW
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 90,
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
                                          color: Colors.grey[300]
                                      ),
                                      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Weight"
                                          ),
                                          SizedBox(height: 5.0),
                                          IntrinsicWidth(
                                            child: TextField(
                                                decoration: null,
                                                enabled: true,
                                                controller: _weightController
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 90,
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                          color: Colors.grey[300]
                                      ),
                                      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Height"
                                          ),
                                          SizedBox(height: 5.0),
                                          IntrinsicWidth(
                                            child: TextField(
                                                decoration: null,
                                                enabled: true,
                                                controller: _heightController
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 90,
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                          color: Colors.grey[300]
                                      ),
                                      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "BMI"
                                          ),
                                          SizedBox(height: 5.0),
                                          IntrinsicWidth(
                                            child: TextField(
                                                decoration: null,
                                                enabled: false,
                                                controller: _bmiController
                                            ),
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
                                  labelStyle: TextStyle(color: Colors.grey,),
                                ),
                              ),
                            ),
                          ]
                      )
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
