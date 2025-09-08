import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/articels_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    try {
      news.clear(); // पहले से मौजूद news को clear करना

      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=480fec5cfe214a3386473c081d0b040d";

      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              publishedAt: element['publishedAt'],
            );
            news.add(articleModel);
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getCategoriesNews(String category) async {
    try {
      news.clear(); // पहले से मौजूद news को clear करना

      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=480fec5cfe214a3386473c081d0b040d";

      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              publishedAt: element['publishedAt'],
            );
            news.add(articleModel);
          }
        });
      }
    } catch (e) {
      print("Error fetching category news: $e");
    }
  }
}
