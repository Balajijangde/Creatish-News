import "package:flutter/material.dart";

class FetchingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text("fetching news", style: TextStyle(
              fontSize: 16.0
            ),)
          ]
        )
      );
  }
}