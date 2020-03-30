import 'package:creatish_news/widgets/NewsWindow.dart';
import "package:flutter/material.dart";
import "package:creatish_news/config.dart";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  TabController _tabController;

  List<Widget> generateTabs(){
    List<Widget> tabs = [];
    appTabs.forEach((f)=>{
      tabs.add(
        Tab(text: f)
      )
    });
    return tabs;
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: appTabs.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool boxIsScrolled){
            return <Widget> [
              SliverAppBar(
                title: Text("Creatish news"),
                floating: true,
                pinned: true,
                forceElevated: boxIsScrolled,

                bottom: TabBar(
                  tabs: generateTabs(),
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelPadding: EdgeInsets.only(right: 60.0, left: 15.0),
                  ),
              )
            ];
          },
          body: TabBarView(children: [
            NewsWindow(),
            Center(child: Text("Text 2")),
            Center(child: Text("Text 3")),
            Center(child: Text("Text 4")),
            Center(child: Text("Text 5")),
            Center(child: Text("Text 6")),
            Center(child: Text("Text 7")),
            Center(child: Text("Text 8"))
          ],
          controller: _tabController,
          )
          ),
      );
  }
}

// import 'package:flutter/material.dart';
// import 'package:creatish_news/config.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: DefaultTabController(
//       length: appTabs.length, // This is the number of tabs.
//       child: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           // These are the slivers that show up in the "outer" scroll view.
//           return <Widget>[
//             SliverOverlapAbsorber(
//               // This widget takes the overlapping behavior of the SliverAppBar,
//               // and redirects it to the SliverOverlapInjector below. If it is
//               // missing, then it is possible for the nested "inner" scroll view
//               // below to end up under the SliverAppBar even when the inner
//               // scroll view thinks it has not been scrolled.
//               // This is not necessary if the "headerSliverBuilder" only builds
//               // widgets that do not overlap the next sliver.
//               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//               child: SliverSafeArea(
//                 top: false,
//                 sliver: SliverAppBar(
//                   title: const Text('Creatish news'), // This is the title in the app bar.
//                   pinned: true,
//                   floating: true,
//                   snap: false,
//                   primary: true,
//                   // The "forceElevated" property causes the SliverAppBar to show
//                   // a shadow. The "innerBoxIsScrolled" parameter is true when the
//                   // inner scroll view is scrolled beyond its "zero" point, i.e.
//                   // when it appears to be scrolled below the SliverAppBar.
//                   // Without this, there are cases where the shadow would appear
//                   // or not appear inappropriately, because the SliverAppBar is
//                   // not actually aware of the precise position of the inner
//                   // scroll views.
//                   forceElevated: innerBoxIsScrolled,
//                   bottom: TabBar(
//                     isScrollable: true,
//                     indicatorColor: Colors.white,
//                     labelPadding: EdgeInsets.only(left:13.0, right:35.0),
//                     tabs: appTabs.map((name) => Tab(text: name)).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: TabBarView(
//           // These are the contents of the tab views, below the tabs.
//           children: appTabs.map((name) {
//             return SafeArea(
//               top: false,
//               bottom: false,
//               child: Builder(
//                 // This Builder is needed to provide a BuildContext that is "inside"
//                 // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
//                 // find the NestedScrollView.
//                 builder: (BuildContext context) {
//                   return CustomScrollView(
//                     // The "controller" and "primary" members should be left
//                     // unset, so that the NestedScrollView can control this
//                     // inner scroll view.
//                     // If the "controller" property is set, then this scroll
//                     // view will not be associated with the NestedScrollView.
//                     // The PageStorageKey should be unique to this ScrollView;
//                     // it allows the list to remember its scroll position when
//                     // the tab view is not on the screen.
//                     key: PageStorageKey<String>(name),
//                     slivers: <Widget>[
//                       SliverOverlapInjector(
//                         // This is the flip side of the SliverOverlapAbsorber above.
//                         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                             context),
//                       ),
//                       SliverPadding(
//                         padding: const EdgeInsets.all(8.0),
//                         // In this example, the inner scroll view has
//                         // fixed-height list items, hence the use of
//                         // SliverFixedExtentList. However, one could use any
//                         // sliver widget here, e.g. SliverList or SliverGrid.
//                         sliver: SliverFixedExtentList(
//                           // The items in this example are fixed to 48 pixels
//                           // high. This matches the Material Design spec for
//                           // ListTile widgets.
//                           itemExtent: 48.0,
//                           delegate: SliverChildBuilderDelegate(
//                             (BuildContext context, int index) {
//                               // This builder is called for each child.
//                               // In this example, we just number each list item.
//                               return ListTile(
//                                 title: Text('Item $index'),
//                               );
//                             },
//                             // The childCount of the SliverChildBuilderDelegate
//                             // specifies how many children this inner list
//                             // has. In this example, each tab has a list of
//                             // exactly 30 items, but this is arbitrary.
//                             childCount: 30,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ));
//   }
// }
