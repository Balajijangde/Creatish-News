import 'dart:convert';
import 'package:creatish_news/widgets/FetchingIndicator.dart';
import 'package:creatish_news/widgets/NewsArticle.dart';
import 'package:creatish_news/config.dart';
import 'package:creatish_news/models/NewsArticleModel.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import "package:http/http.dart" as http;
import 'package:logger/logger.dart';

class NewsWindow extends StatefulWidget {
  @override
  _NewsWindowState createState() => _NewsWindowState();
}

class _NewsWindowState extends State<NewsWindow> with AutomaticKeepAliveClientMixin {
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
      return Center(child: FetchingIndicator());
    } else if (!this._isFetching && this.news.length == 0) {
      return Center(child: Text("error occured"));
    } else {
      return ListView.builder(
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) => NewsArticle(article: news[index]),
        itemCount: news.length
        );
      // SliverList(
      //     delegate: SliverChildBuilderDelegate(
      //         (context, index) => NewsArticle(article: news[index]),
      //         childCount: news.length));
    
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

  // @override
  // Widget build(BuildContext context) {
  //   return CustomScrollView(
  //         controller: _controller,
  //         slivers: <Widget>[
  //           this.renderTrendingScreen(),
  //           SliverList(
  //               delegate: SliverChildListDelegate([
  //             this._isFetchingAnotherPage && !this._isFetching
  //                 ? (Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 30.0),
  //                     child: Column(children: [
  //                       CircularProgressIndicator(),
  //                       SizedBox(height: 10.0),
  //                     ]),
  //                   ))
  //                 : (Container())
  //           ]))
  //         ],
  //       );
  // }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("cjdanc")
      ]
    );
  }

  @override
  bool get wantKeepAlive => true;
}
