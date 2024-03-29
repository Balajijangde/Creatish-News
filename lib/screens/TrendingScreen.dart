import 'dart:convert';
import 'package:creatish_news/screens/SearchPage.dart';
import 'package:creatish_news/widgets/AppDrawer.dart';
import 'package:creatish_news/widgets/FetchingIndicator.dart';
import 'package:creatish_news/widgets/NewsArticle.dart';
import 'package:creatish_news/config.dart';
import 'package:creatish_news/models/NewsArticleModel.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import "package:http/http.dart" as http;
import 'package:logger/logger.dart';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  ScrollController _controller;
  Logger log = Logger();
  bool _isFetching = false;
  bool _isFetchingAnotherPage = false;
  int _pageToFetch = 1;
  List<NewsArticleModel> news = [];

  isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  void fetchNews() async {
    setState(() {
      _isFetching = true;
    });
    try {
      var response = await http.get(baseurl + api + posts + embed);
      List<NewsArticleModel> realNews = [];
      jsonDecode(response.body)
          .forEach((news) => realNews.add(NewsArticleModel.fromJSON(news)));
      setState(() {
        news.addAll(realNews);
        _isFetching = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isFetching = false;
      });
    }
  }

  void fetchMoreNews() async {
    setState(() {
      _isFetchingAnotherPage = true;
    });
    try {
      var response = await http
          .get(baseurl + api + posts + embed + "&page=${this._pageToFetch}");
      List<NewsArticleModel> realNews = [];
      jsonDecode(response.body)
          .forEach((news) => realNews.add(NewsArticleModel.fromJSON(news)));
      setState(() {
        news.addAll(realNews);
        _isFetchingAnotherPage = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isFetchingAnotherPage = false;
      });
    }
  }

  Widget renderTrendingScreen() {
    if (this._isFetching) {
      return SliverFillRemaining(child: FetchingIndicator());
    } else if (!this._isFetching && this.news.length == 0) {
      return SliverFillRemaining(child: Text("error occured"));
    } else {
      return SliverPadding(
        padding: EdgeInsets.only(top:7.0),
              sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => NewsArticle(article: news[index]),
                childCount: news.length)),
      );
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        !_isFetching &&
        !_isFetchingAnotherPage) {
      _pageToFetch += 1;
      fetchMoreNews();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        //backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              snap: true,
              centerTitle: true,
              title: Text("Trending"),
              floating: true,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SearchPage()
                      )
                  );
                })
              ],
            ),
            this.renderTrendingScreen(),
            SliverList(
                delegate: SliverChildListDelegate([
              this._isFetchingAnotherPage && !this._isFetching
                  ? (Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10.0),
                      ]),
                    ))
                  : (Container())
            ]))
          ],
        ));
  }
}
