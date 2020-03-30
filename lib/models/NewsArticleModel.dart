import 'package:logger/logger.dart';

class NewsArticleModel {
    int id;
    bool hasImage = false;
    DateTime postedOn;
    String displayDateTimeStamp;
    DateTime modifiedOn;
    String postLink;
    String thumbnailSmall;
    String title;

    //NOTE remove this if got a way to fetch limited resources
    String content;
    Map<String, dynamic> author;
    String thumbnailLarge;
    List categories = [];
    List tags = [];
    Logger log = Logger();

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

    String getDate(DateTime tempdate) {
        DateTime currentDateTimeStamp = DateTime.now();
        Duration diff = currentDateTimeStamp.difference(tempdate);
        if (diff.inSeconds < 60) {
            String ap = diff.inSeconds != 1 ? "s" : "";
            return "${diff.inSeconds} second$ap ago";
        } else if (diff.inMinutes < 60) {
            String ap = diff.inMinutes != 1 ? "s" : "";
            return "${diff.inMinutes} minute$ap ago";
        } else if (diff.inHours < 24) {
            String ap = diff.inHours != 1 ? "s" : "";
            return "${diff.inHours} hour$ap ago";
        } else if (diff.inDays < 30) {
            String ap = diff.inDays != 1 ? "s" : "";
            return "${diff.inDays} day$ap ago";
        } else {
            return tempdate.day.toString() +
                "-" +
                getMonth(tempdate.month) +
                "-" +
                tempdate.year.toString();
        }
    }

    NewsArticleModel.fromJSON(Map<String, dynamic> data) {
        this.id = data["id"];
        this.postedOn = DateTime.parse(data["date"]);
        this.displayDateTimeStamp = getDate(DateTime.parse(data["date"]));
        this.modifiedOn = DateTime.parse(data["modified"]);
        this.postLink = data["link"];
        this.title = data["title"]["rendered"];
        this.content = data["content"]["rendered"];
        try {
            this.thumbnailSmall = data["_embedded"]["wp:featuredmedia"][0]
            ["media_details"]["sizes"]["thumbnail"]["source_url"];
            this.thumbnailLarge = data["_embedded"]["wp:featuredmedia"][0]
            ["media_details"]["sizes"]["full"]["source_url"];
            this.hasImage = true;
        } catch (e) {
            this.hasImage = false;
        }
        // NOTE remove this if got a way to fetch limited resources
        this.author = {
            "id": data["author"],
            "name": data["_embedded"]["author"][0]["name"]
        };
        //var somedata = jsonDecode(data["_embedded"]["wp:term"][0]);

        try {
            List tempCategories = data["_embedded"]["wp:term"][0];
            tempCategories.forEach((f) => {
                this.categories.add({"id": f["id"], "name": f["name"]})
            });
        } catch (e) {
            this.categories = [];
        }
        try {
            List tempTags = data["_embedded"]["wp:term"][1];
            tempTags.forEach((f) => {
                this.tags.add({"id": f["id"], "name": f["name"]})
            });
        } catch (e) {
            this.tags = [];
        }
    }
}
