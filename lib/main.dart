import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:strydeapp/services/behavior.dart';
import 'welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
        title: 'Stryde',
        home: Welcome(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
