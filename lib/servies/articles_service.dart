import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/articels_model.dart';

class ArticlesService {
  Future<List<ArticleModel>> fetchByCategory(String category) async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=480fec5cfe214a3386473c081d0b040d";

    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    final List<ArticleModel> articles = [];

    if (jsonData['status'] == 'ok') {
      for (final element in jsonData['articles']) {
        if (element['urlToImage'] != null && element['description'] != null) {
          articles.add(
            ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              publishedAt: element['publishedAt'],
              author: element['author'],
            ),
          );
        }
      }
    }

    return articles;
  }
}
