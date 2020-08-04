import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:price_checker/utilities/rootChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isReady = false;
List<String> imgList = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  String messageText;
  @override
  void initState() {
    super.initState();
    rootChecker();
  }

  setURLData(stringKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String stringValue = prefs.getString('stringValue');
      var listInt = prefs.getInt('listInt');
      prefs.setString('stringValue', stringValue + '"' + stringKey);
      prefs.setInt('listInt', listInt + 1);
      setState(() {
        prefs.setBool('isReady', true);
      });
    } catch (e) {
      prefs.setString('stringValue', stringKey);
      prefs.setInt('listInt', 1);
      setState(() {
        prefs.setBool('isReady', true);
      });
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
      var listInt = prefs.getInt('listInt');
      if (listValue != null && imgList.length < listInt) {
        List bigList = listValue.split('"');
        for (var i = 0; i < bigList.length; i++) {
          if (imgList.length < listInt) {
            List smallList = [];
            smallList.add(bigList[i].toString().split('+'));
            setState(() {
              imgList.add(smallList[0][2]);
            });
          } else {
            break;
          }
        }
        if (stringValue != null) {
          setState(() {
            isReady = prefs.getBool('isReady');
          });
        } else {
          setState(() {
            isReady = false;
          });
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        isReady = false;
      });
    }
  }

  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();
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
            Container(
              child: CarouselSlider.builder(
                  key: _sliderKey,
                  unlimitedMode: true,
                  slideBuilder: (index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No. $index image',
                        style: TextStyle(fontSize: 200, color: Colors.white),
                      ),
                    );
                  },
                  slideTransform: CubeTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: 32),
                  ),
                  itemCount: imgList.length),
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
          ]),
        ),
      );
    }
  }
}
