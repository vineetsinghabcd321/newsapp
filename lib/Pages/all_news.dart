import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Models/articels_model.dart';
import 'package:newsapp/Models/slider_model.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/servies/news_service.dart';
import 'package:newsapp/servies/slider_data.dart';

class AllNews extends StatefulWidget {
  final String news;
  const AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> slider = [];
  List<ArticleModel> articles = [];

  int activeIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getSlider();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    if (widget.news == "Trending") {
      await newsClass.getNews();
    } else {
      await newsClass.getCategoriesNews(widget.news.toLowerCase());
    }
    setState(() {
      articles = newsClass.news;
      _loading = false;
    });
  }

  getSlider() async {
    var sliderData = SliderService();
    await sliderData.getSlider();
    setState(() {
      slider = sliderData.slider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.grey,
        title: Text(
          "${widget.news} News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.news == "Breaking"
                    ? slider.length
                    : articles.length,
                itemBuilder: (context, index) {
                  if (widget.news == "Breaking") {
                    return AllNewsSection(
                      Image: slider[index].urlToImage!,
                      desc: slider[index].description!,
                      title: slider[index].title!,
                      url: slider[index].url!,
                    );
                  } else {
                    if (articles.length > 0) {
                      return AllNewsSection(
                        Image: articles[index].urlToImage!,
                        desc: articles[index].description!,
                        title: articles[index].title!,
                        url: articles[index].url!,
                      );
                    } else {
                      return Container(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Loading articles...',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String Image, desc, title, url;
  const AllNewsSection({
    super.key,
    required this.Image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: Image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          desc,
                          maxLines: 3,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(86, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
