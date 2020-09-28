import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strydeapp/services/globals.dart' as globals;

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<String> getUid() async {
    return _firebaseAuth.currentUser.uid;
  }

  /// Gets user data from database using their uid, then
  /// saves it to the global variables
  Future getData() async {
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

    usersReference = FirebaseDatabase.instance.reference().child("users").child(userId).child("weight_data");
    usersReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        globals.weight_data.add({
          'weight': value["weight"].toDouble(),
          'date': DateTime.fromMillisecondsSinceEpoch(value["date"])
        });
      });
      globals.weight_data.sort((a, b) => a['date'].compareTo(b['date']));
    });

  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<void> putSignupData({
    @required String email,
    @required String password,
    @required String name,
    @required int age,
    @required String sex,
    @required double height,
    @required double weight,
    @required String injury_history
  }) async  {
    try {
      String userId = _firebaseAuth.currentUser.uid;
      var usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.update({'email' : email});
      usersReference.update({'password' : password});
      usersReference.update({'name' : name});
      usersReference.update({'age' : age});
      usersReference.update({'sex' : sex});
      usersReference.update({'height' : height});
      usersReference.update({'weight' : weight});
      usersReference.update({'injury_history' : injury_history});
      usersReference.update({'weight_data': ''});
      usersReference = FirebaseDatabase.instance.reference().child("users").child(userId).child("weight_data").push();
      usersReference.update({'date': ServerValue.timestamp});
      usersReference.update({'weight': weight});
    } catch (e) {

    }
  }

  Future<void> putWeight(weight) async {
    try {
      String userId = _firebaseAuth.currentUser.uid;
      var usersReference = FirebaseDatabase.instance.reference().child("users").child(userId).child("weight_data").push();
      usersReference.update({'date': ServerValue.timestamp});
      usersReference.update({'weight': weight});
    } catch (e) {
    }
  }

  Future<String> signOut()  async {
    await _firebaseAuth.signOut();
    return Future.value("Logged out");
  }
}
