import 'dart:convert';
import 'package:creatish_news/widgets/FetchingIndicator.dart';
import 'package:creatish_news/widgets/NewsArticle.dart';
import 'package:creatish_news/config.dart';
import 'package:creatish_news/models/NewsArticleModel.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import "package:http/http.dart" as http;

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  bool _isConnected = false;
  bool _isFetching = false;
  List<NewsArticleModel> news = [];

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });
    } else {
      setState(() {
        _isConnected = false;
      });
    }
  }

  void fetchNews(int page) async {
    setState(() {
      _isFetching = true;
    });
    try {
      var response = await http
          .get(baseurl+api+posts+embed+"&page=$page");
      List<NewsArticleModel> realNews = [];
      jsonDecode(response.body)
          .forEach((news) => realNews.add(NewsArticleModel.fromJSON(news)));
      setState(() {
        news = [...realNews];
        _isFetching = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isFetching = false;
      });
    }
  }

  Widget renderTrendingScreen() {
    if (this._isFetching) {
      return SliverFillRemaining(child: FetchingIndicator());
    } else if (!this._isFetching && this.news.length == 0) {
      return SliverFillRemaining(child: Text("error occured"));
    } else {
      return SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => NewsArticle(
                    article: news[index]
                  ),
              childCount: news.length));
    }
  }

  @override
  void initState() {
    super.initState();
    //checkConnectivity();
    fetchNews(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text("Trending"),
              floating: true,
            ),
            this.renderTrendingScreen()
          ],
        ));
  }
}
