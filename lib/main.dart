import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:strydeapp/services/behavior.dart';
import 'package:strydeapp/services/firebase_service_model.dart';
import 'home.dart';
import 'welcome.dart';
import 'services/globals.dart' as globals;

void main() async {
  // Needed to initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var as = AuthenticationService();
  as.getData();

  if(userIsLoggedIn())  {
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
      runApp(
        MaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            );
          },
          title: 'Stryde',
          home: LandingPage(),
        ),
      );
    });
  } else  {
    runApp(
      MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        title: 'Stryde',
        home: LandingPage(),
      ),
    );
  }
}

/// Returns true if the user is logged in
bool userIsLoggedIn() {
  if(FirebaseAuth.instance.currentUser != null) {
    print("User is logged in");
    return true;
  } else  {
    print("User is NOT logged in");
    return false;
  }
}

Future<void> getAndSetGlobalData() async {

}

/// Returns a Home if user is logged in, otherwise returns Welcome
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _decideMainPage(),
    );
  }
  _decideMainPage() {
    if (userIsLoggedIn()) {
      return Home();
    } else {
      return Welcome();
    }
  }
}
