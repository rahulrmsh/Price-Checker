import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:price_checker/utilities/product-scrapper.dart';

final List<String> imgList = [
  'https://images-na.ssl-images-amazon.com/images/I/51WKFjmQSKL._SL1196_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/61R%2B5yDNShL._SY355_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/61R%2B5yDNShL._SY355_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/811u6QEwQxL._SL1500_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/51vGmpKyULL._SL1000_.jpg',
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              color: Colors.white,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.fitHeight, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'Product ${imgList.indexOf(item) + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
  @override
  void initState() {
    super.initState();
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel with indicator demo')),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 60,
          ),
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}
