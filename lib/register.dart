import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dropdowns.dart';
import 'home.dart';
import 'services/firebase_service_model.dart';
import 'services/globals.dart' as globals;

var _emailController = TextEditingController();
var _passwordController = TextEditingController();
var _nameController = TextEditingController();
var _injury_historyController = TextEditingController();

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<bool> signUp(
      {@required String email,
      @required String password,
      @required String name,
      @required int age,
      @required String sex,
      @required double height,
      @required double weight,
      @required String injury_history}) async {
    await _authenticationService
        .signUpWithEmail(email: email, password: password)
        .then((value) async {
      _authenticationService.putSignupData(
          email: email,
          password: password,
          name: name,
          age: age,
          sex: sex,
          height: height,
          weight: weight,
          injury_history: injury_history);
    });
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String userId = _firebaseAuth.currentUser.uid;
    var usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
    usersReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      globals.name = values['name'].toString();
      globals.age = values['age'].toString();
      globals.weight = values['weight'].toString();
      globals.height = values['height'].toString();
      globals.injury_history = values['injury_history'].toString();
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    HeightDropdown heightDropdown = HeightDropdown();
    AgeDropdown ageDropdown = AgeDropdown();
    GenderDropdown genderDropdown = GenderDropdown();
    WeightDropdown weightDropdown = WeightDropdown();

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    return Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
//          new TextEditingController().clear();
            },
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign-Up",
                          style: TextStyle(
                            color: Color(0xFF409ded),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
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
                      SizedBox(height: 25),
                      TextFormField(
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
                      SizedBox(height: 25),
                      TextFormField(
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [AgeDropdown(), GenderDropdown()],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [heightDropdown, WeightDropdown()],
                      ),
                      SizedBox(height: 30),
                      Container(
//                      width: 300,
                        child: TextFormField(
                          controller: _injury_historyController,
                          maxLines: 4,
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF0F0F0),
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  10.0, 20.0, 10.0, 5.0),
                              border: OutlineInputBorder(),
                              labelText: 'History of injuries (if any)',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        onPressed: () {
                          print(heightDropdown.getHeight);
                          print(weightDropdown.getWeight);
                          print(genderDropdown.getSex);
                          print(ageDropdown.getAge);
                          signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                              age: int.parse(ageDropdown.getAge),
                              sex: genderDropdown.getSex,
                              height: double.parse(heightDropdown.getHeight),
                              weight: double.parse(weightDropdown.getWeight),
                              injury_history: _injury_historyController.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: Color(0xFF409ded),
                          ),
                          width: 130,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: const Text('Sign Up',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            )));
  }
}
