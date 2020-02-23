import 'package:evans_translator/widgets/bottom_bar_navigation_pattern/bottomnav_bar_custom.dart';
import 'package:evans_translator/widgets/bottomnav_bar.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[600],
      ),
      home: BottomNav_C(),
    );
  }
}
