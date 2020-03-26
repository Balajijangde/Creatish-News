import 'package:creatish_news/config.dart';
import 'package:creatish_news/models/NewsArticleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen(this.article);
  final NewsArticleModel article;
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState(this.article);
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  _NewsDetailScreenState(this.article);
  NewsArticleModel article;

  @override
  void initState() {
    super.initState();
  }
  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
      default:
        return "None";
        break;
    }
  }
  List<Widget> renderCategories() {
      List<Widget> widlist = [];
      article.categories
          .forEach((f) => {widlist.add(Chip(label: Text(f["name"])))});
      return widlist;
  }
  List<Widget> renderTags() {
      List<Widget> widlist = [];
      article.tags
          .forEach((f) => {widlist.add(Chip(label: Text(f["name"])))});
      return widlist;

  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share("${article.postLink}");
              })
        ],
        pinned: true,
        expandedHeight: 220.0,
        flexibleSpace: FlexibleSpaceBar(
            background: article.hasImage
                ? (FadeInImage.assetNetwork(
                    placeholder: phImage,
                    image: article.thumbnailLarge,
                    fit: BoxFit.cover,
                  ))
                : (Image.asset(phImage, fit: BoxFit.cover))),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          Text(
            article.title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30.0),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              Text("  ${article.postedOn.day}-${getMonth(article.postedOn.month)}-${article.postedOn.year}")
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              Icon(Icons.schedule),
              Text("  ${article.postedOn.hour}:${article.postedOn.minute}")
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              Icon(Icons.create),
              Text("  ${article.author["name"]}")
            ],
          ),
          SizedBox(height:20.0),
          article.categories.length !=0?Text("Categories :",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor)):Container(),
          Wrap(
            children: renderCategories(),
          ),
          article.tags.length!=0?Text("Tags :",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor)):Container(),
          Wrap(
            children: renderTags(),
          ),
          Divider(),
          Html(
            data: article.content,
            defaultTextStyle: TextStyle(fontSize: 18),
          )
        ])),
      )
    ]));
  }
}
