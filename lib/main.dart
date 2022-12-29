import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // ignore: prefer_typing_uninitialized_variables
  var _backgroundColor;

  @override
  void initState() {
    _backgroundColor = Colors.red;
    super.initState();
  }

  void _changeColor(int page) {
    setState(() {
      List colors = [
        Colors.red,
        Colors.redAccent,
        Colors.deepPurpleAccent,
        Colors.red,
        Colors.teal,
        Colors.blue,
        Colors.deepPurple];

      _backgroundColor = colors[page];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white12,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                alignment: Alignment.bottomLeft,
                child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(width: 500, height: 400, color: _backgroundColor)
                )),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image.asset('assets/marvel.png', width: 200, height: 50)
                ),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        'Choose your hero',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  width: 400,
                  height: 400,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: _changeColor,
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildCard('assets/deadpool.jpg', 'Deadpool'),
                      buildCard('assets/ironman.jpg', 'Ironman'),
                      buildCard('assets/captainamerica.jpeg', 'Captain America'),
                      buildCard('assets/spiderman.jpg', 'Spiderman'),
                      buildCard('assets/doctorstrange.jpg', 'Doctor Strange'),
                      buildCard('assets/thor.jpg', 'Thor'),
                      buildCard('assets/thanos.webp', 'Thanos')
                    ],
                  ),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}

Widget buildCard(String imageUrl, String heroName) => Card(
  clipBehavior: Clip.antiAlias,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  child: Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(imageUrl, width: 300, height: 400, fit: BoxFit.cover),
      Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.bottomLeft,
          child: Text(
              heroName,
              style: const TextStyle(
                  fontSize: 20, color: Colors.white,
                  fontWeight: FontWeight.bold)))
    ],
  ),
);

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


