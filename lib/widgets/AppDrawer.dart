import 'package:flutter/material.dart';
import 'package:creatish_news/config.dart';

class AppDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Image.asset("images/cr2pn.png"),
            accountName: Text("Creatish"), 
            accountEmail: Text("creatish.in@gmail.com")),
          for(String t in appTabs) ListTile(trailing: Icon(Icons.arrow_right),title: Text(t), leading: Icon(Icons.ac_unit),)
        ],
      ),
    );
  }
}
