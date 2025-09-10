// lib/pages/category_news.dart
import 'package:flutter/material.dart';
import 'package:newsapp/Models/articels_model.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/servies/news_service.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsService = News();
    await newsService.getCategoriesNews(widget.category.toLowerCase());
    categories = newsService.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.grey,
        title: Text(
          widget.category,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : categories.isEmpty
          ? Center(
              child: Text(
                'No news found for ${widget.category}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: categories.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleView(
                              blogUrl: categories[index].url ?? '',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (categories[index].urlToImage != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      categories[index].urlToImage!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                SizedBox(height: 10),
                                Text(
                                  categories[index].title ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  categories[index].description ??
                                      'No Description',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
