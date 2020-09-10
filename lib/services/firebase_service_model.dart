import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
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

  Future getUid() async {
    return (await _firebaseAuth.currentUser()).uid;
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
  Future putSignupData({
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
      String userId = (await _firebaseAuth.currentUser()).uid;
      final usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.update({'email' : email});
      usersReference.update({'password' : password});
      usersReference.update({'name' : name});
      usersReference.update({'age' : age});
      usersReference.update({'sex' : sex});
      usersReference.update({'height' : height});
      usersReference.update({'weight' : weight});
      usersReference.update({'injury_history' : injury_history});
    } catch (e) {

    }
  }

  Future<String> signOut()  async {
    await _firebaseAuth.signOut();
    return Future.value("Logged out");
  }
}
