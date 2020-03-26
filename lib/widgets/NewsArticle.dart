import 'package:creatish_news/models/NewsArticleModel.dart';
import 'package:creatish_news/screens/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:creatish_news/config.dart';

class NewsArticle extends StatelessWidget {
  NewsArticle({this.article});
  final NewsArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => NewsDetailScreen(article))),
      child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: <Widget>[
              Container(
                  width: 150.0,
                  height: 140.0,
                  child: article.hasImage?(FadeInImage.assetNetwork(
                    placeholder: phImage, 
                    image: article.thumbnailSmall,
                    fit: BoxFit.cover,
                    )):(Image.asset(phImage, fit: BoxFit.cover))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        article.title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.schedule,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text("  " + article.displayDateTimeStamp)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
