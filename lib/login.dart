import 'package:flutter/material.dart';
import 'package:strydeapp/welcome.dart';
import 'connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'services/firebase_service_model.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthenticationService authenticationService = AuthenticationService();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool _success;
  String _userEmail;

  /// Signs in with email and password from text controllers
  Future _signInWithEmailAndPassword() async {
    var user = (await _firebaseAuth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }



  /// Executes _signInWithEmailAndPassword and getData
  Future login() async {
    try {
      print('Attempting to login...');
      await _signInWithEmailAndPassword().then((value) {
        print('Successfully logged in');
        authenticationService.getData();
        // Changing page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Connector(0)));
      });
    } catch (err) {
      print('Caught error: $err');
      print('Failed to login');
      Fluttertoast.showToast(msg: "Failed to login", toastLength: Toast.LENGTH_SHORT, backgroundColor: Colors.black, gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Heading
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Margin
                    const SizedBox(height: 30),
                    // TextFields
                    Container(
                        width: 300,
                        child: Column(children: [
                          // Email TextField
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
                          // Password TextField
                          const SizedBox(height: 30),
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
                        ])),

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

                        // Login Button
                        const SizedBox(width: 20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            // Un-focus keyboard
                            FocusScope.of(context).requestFocus(FocusNode());
                            login();
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
                            child: const Text('Log In', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 300),
                  ],
                ),
              )
            ])
        )
    );
  }
}
