import 'package:flutter/material.dart';
import 'package:strydeapp/services/behavior.dart';
import 'welcome.dart';

void main() {
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
