import 'package:flutter/material.dart';
import 'package:newsapp/Models/categories_model.dart';
import 'package:newsapp/Models/slider_model.dart';
import 'package:newsapp/Pages/all_news.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/Pages/categories_news.dart';
import 'package:newsapp/servies/Data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsapp/servies/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HoomePage extends StatefulWidget {
  const HoomePage({super.key});

  @override
  State<HoomePage> createState() => _HoomePageState();
}

int activeIndex = 0;

class _HoomePageState extends State<HoomePage> {
  List<SliderModel> slider = [];

  @override
  void initState() {
    super.initState();
    getSlider();
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
        title: Text(
          'News App',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(152, 158, 158, 158),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(padding: EdgeInsets.all(10), child: CategoriesList()),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Breaking News!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllNews(news: "Breaking"),
                        ),
                      );
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider.builder(
              itemCount: slider.length > 0 ? slider.length : 1,
              itemBuilder: (context, index, realIndex) {
                if (slider.length == 0) {
                  return Container(
                    height: 250,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                            'Loading news...',
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
                return buildImage(
                  slider[index].urlToImage!,
                  index,
                  slider[index].title!,
                );
              },
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 2),

                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            buildIndicator(),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Trending News!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllNews(news: "Trending"),
                        ),
                      );
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // step 5 BlogTile
            Container(
              child: slider.length > 0
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: slider.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          url: slider[index].url!,
                          imageUrl: slider[index].urlToImage!,
                          title: slider[index].title!,
                          desc: slider[index].description!,
                        );
                      },
                    )
                  : Container(
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  const BlogTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
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
                      imageUrl: imageUrl,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 30,
                          ),
                        ),
                      ),
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

Widget buildImage(String image, int index, String name) {
  return SizedBox(
    height: 250,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.blue, strokeWidth: 3),
                  SizedBox(height: 10),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Image not available',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildIndicator() => AnimatedSmoothIndicator(
  activeIndex: activeIndex,
  count: 5,
  effect: SlideEffect(
    dotWidth: 15,
    dotHeight: 15,
    activeDotColor: Colors.blue,
    dotColor: Colors.black12,
  ),
);

class CategoriesTile extends StatelessWidget {
  final String image, categoriesName;

  const CategoriesTile({
    super.key,
    required this.image,
    required this.categoriesName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(category: categoriesName),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 6, left: 6, top: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categoriesName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Categories> categories = getCategories();

    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoriesTile(
            image: categories[index].image,
            categoriesName: categories[index].categoriesName,
          );
        },
      ),
    );
  }
}
