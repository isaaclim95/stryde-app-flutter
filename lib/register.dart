import 'package:flutter/material.dart';
import 'dropdowns.dart';
import 'services/firebase_service_model.dart';
import 'firstrun.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {

  final AuthenticationService _authenticationService = AuthenticationService();

  void signUp({@required String email,
      @required String password,
      @required String name,
      @required int age,
      @required String sex,
      @required double height,
      @required double weight,
      @required String injury_history}) async {
    _authenticationService.signUpWithEmail(email: email, password: password);
    _authenticationService.putSignupData(email: email, password: password, name: name,
        age: age, sex: sex, height: height, weight: weight, injury_history: injury_history);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _injury_historyController = TextEditingController();

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Sign-Up",
                        style: TextStyle(
                          color: Color(0xFF409ded),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height:20),
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
                    SizedBox(height:20),
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
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AgeDropdown(),
                        GenderDropdown()
                      ],
                    ),
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HeightDropdown(),
                        WeightDropdown()
                      ],
                    ),
                    SizedBox(height:20),
                    Container(
//                      width: 300,
                      child: TextFormField(
                        controller: _injury_historyController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFF0F0F0),
                          filled: true,
                          contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
                          border: OutlineInputBorder(),
                          labelText: 'History of injuries (if any)',
                          labelStyle: TextStyle(color: Colors.grey,),
                        ),
                      ),
                    ),
                    RaisedButton(
//                      onPressed: signOut,
                      onPressed: ()   {
                        signUp(email: _emailController.text, password: _passwordController.text,
                        name: _nameController.text, age: 24, sex: "Male", height: 179,
                        weight: 70, injury_history: _injury_historyController.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Firstrun()));
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
                        child: const Text('Sign Up', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        )
      )
    );
  }
}
