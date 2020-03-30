import 'package:creatish_news/screens/TrendingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  ThemeData theme = ThemeData(primarySwatch: Colors.deepOrange);
  void changeTheme(){
    setState(() {
      theme = ThemeData.dark();
    });
  }

  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token){
      print(token);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Creatish news',
        theme: theme,
        home: TrendingScreen());
  }
}
