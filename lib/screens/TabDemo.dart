import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> with SingleTickerProviderStateMixin{
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool boxIsScrolled){
            return <Widget> [
              SliverAppBar(
                title: Text("some title"),
                floating: true,
                pinned: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "something",
                      icon: Icon(Icons.mail),
                    ),
                    Tab(
                      text: "something",
                      icon: Icon(Icons.mail),
                    ),
                    Tab(
                      text: "something",
                      icon: Icon(Icons.mail),
                    ),
                    Tab(
                      text: "something",
                      icon: Icon(Icons.mail),
                    ),
                    Tab(
                      text: "something",
                      icon: Icon(Icons.mail),
                    )
                  ],
                  controller: _tabController,
                  ),
              )
            ];
          }, 
          body: TabBarView(children: [
            Center(child: Text("Text 1")),
            Center(child: Text("Text 2")),
            Center(child: Text("Text 3")),
            Center(child: Text("Text 4")),
            Center(child: Text("Text 5"))
          ],
          controller: _tabController,
          )
          ),
      )
    );
  }
}