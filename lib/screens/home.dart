import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:price_checker/utilities/rootChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isReady = false;
List<String> imgList = [
  'https://images-na.ssl-images-amazon.com/images/I/51WKFjmQSKL._SL1196_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/61R%2B5yDNShL._SY355_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/61R%2B5yDNShL._SY355_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/811u6QEwQxL._SL1500_.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/51vGmpKyULL._SL1000_.jpg',
];
List<String> imgList1 = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  String messageText;
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
    rootChecker();
  }

  setURLData(stringKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String stringValue = prefs.getString('stringValue');
      prefs.setString('stringValue', stringValue + '"' + stringKey);
      prefs.setBool('isReady', true);
    } catch (e) {
      prefs.setString('stringValue', stringKey);
      prefs.setBool('isReady', true);
    }
  }

  getURLData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString('stringValue');
      print(stringValue);
    } catch (e) {
      print(e);
    }
  }

  getReady() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString('stringValue');
      String listValue = prefs.getString('listValue');
      List bigList = listValue.split('"');
      for (var i = 0; i < bigList.length; i++) {
        List smallList = [];
        smallList.add(bigList[i].toString().split('+'));
        imgList1.add(smallList[0][2]);
      }
      print(imgList1);
      if (stringValue != null) {
        setState(() {
          isReady = prefs.getBool('isReady');
        });
      } else {
        setState(() {
          isReady = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isReady = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getReady();
    if (isReady == false) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Carousel with indicator demo')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: AnimatedButton(
              text: 'Add',
              color: Colors.grey[700],
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.SUCCES,
                  btnOkText: 'ADD',
                  btnOkColor: Colors.greenAccent[700],
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(),
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.greenAccent[700], width: 2.0)),
                          border: InputBorder.none,
                          labelText: "Link Here",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkOnPress: () {
                    setURLData(messageText);
                  },
                )..show();
              },
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text('Carousel with indicator demo')),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: AnimatedButton(
                text: 'Add',
                color: Colors.grey[700],
                pressEvent: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.SUCCES,
                    btnOkText: 'ADD',
                    btnOkColor: Colors.greenAccent[700],
                    body: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(),
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: Colors.greenAccent[700],
                                    width: 2.0)),
                            border: InputBorder.none,
                            labelText: "Link to be Added",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    title: 'This is Ignored',
                    desc: 'This is also Ignored',
                    btnOkOnPress: () {
                      setURLData(messageText);
                    },
                  )..show();
                },
              ),
            ),
            SizedBox(
              height: 80,
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
            SizedBox(
              height: 80,
            ),
            FlatButton(
              onPressed: () {
                getURLData();
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[500],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                child: Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.red[500],
                ),
              ),
            ),
          ]),
        ),
      );
    }
  }
}
