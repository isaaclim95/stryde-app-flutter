import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:strydeapp/services/behavior.dart';
import 'package:strydeapp/services/firebase_service_model.dart';
import 'welcome.dart';
import 'connector.dart';

Future<void> main() async {
  // Needed to initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AuthenticationService as = AuthenticationService();

  if(userIsLoggedIn())  {
    await getAndSetGlobalData().then((value) => null);
  }

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
  final AuthenticationService authenticationService = AuthenticationService();
  authenticationService.getData();
}

/// Returns a Connector if user is logged in, otherwise returns welcome screen
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _decideMainPage(),
    );
  }
  _decideMainPage() {
    if (userIsLoggedIn()) {
      return Connector(0);
    } else {
      return Welcome();
    }
  }
}
