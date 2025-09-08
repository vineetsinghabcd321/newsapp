import 'package:flutter/material.dart';
import 'package:newsapp/Pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(30),
                child: Image.asset('images/building.jpg'),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'News from around the world for you',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Best time to read, take your time to read a little more of this world',
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10),

            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),

              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HoomePage()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
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
