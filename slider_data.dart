import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/Models/slider_model.dart';

class SliderService {
  List<SliderModel> slider = [];

  Future<void> getSlider() async {
    const String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=480fec5cfe214a3386473c081d0b040d";

    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          final SliderModel sliderModel = SliderModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
            author: element['author'],
          );
          slider.add(sliderModel);
        }
      });
    }
  }
}
