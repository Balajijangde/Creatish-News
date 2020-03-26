import 'package:flutter/material.dart';
import 'screens/TrendingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creatish news',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TrendingScreen()
    );
  }
}
