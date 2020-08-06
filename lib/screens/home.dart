import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:price_checker/utilities/removeURL.dart';
import 'package:price_checker/utilities/rootChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isReady = false;
List<String> imgList = [];
List<String> productList = [];
List<String> priceList = [];
List<String> urlList = [];
List<String> rateList = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String messageText;
  @override
  void initState() {
    super.initState();
    rootChecker();
  }

  setURLData(stringKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (stringKey != null && stringKey != '') {
      try {
        String stringValue = prefs.getString('stringValue');
        var initialList = stringValue.split('"');
        if (!(initialList.contains(stringKey))) {
          var listInt = prefs.getInt('listInt');
          setState(() {
            prefs.setString('stringValue', stringValue + '"' + stringKey);
            prefs.setInt('listInt', listInt + 1);
            prefs.setBool('isReady', true);
            rootChecker();
          });
        }
      } catch (e) {
        setState(() {
          prefs.setString('stringValue', stringKey);
          prefs.setInt('listInt', 1);
          prefs.setBool('isReady', true);
          rootChecker();
        });
      }
    }
  }

  getReady() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString('stringValue');
      String listValue = prefs.getString('listValue');
      var listInt = prefs.getInt('listInt');
      var strList = stringValue.split('"');
      print("URL NOW IS" + strList[1]);
      if (listValue != null && imgList.length < listInt) {
        List bigList = listValue.split('"');
        imgList = [];
        priceList = [];
        productList = [];
        rateList = [];
        for (var i = 0; i < bigList.length; i++) {
          if (imgList.length <= listInt &&
              urlList.length <= listInt &&
              priceList.length <= listInt &&
              productList.length <= listInt) {
            List smallList = [];
            smallList.add(bigList[i].toString().split('+'));
            setState(() {
              urlList.add(strList[i + 1]);
              rateList.add(smallList[0][3]);
              imgList.add(smallList[0][2]);
              priceList.add(smallList[0][1]);
              productList.add(smallList[0][0]);
            });
          } else {
            break;
          }
          print("URL LIST : " +
              urlList.toString() +
              "IMG LIST" +
              imgList.toString());
        }
        if (listInt > 0) {
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
                    setState(() {
                      setURLData(messageText);
                    });
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
            SizedBox(height: 80),
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
            Container(
              padding: EdgeInsets.all(20),
              height: 500,
              color: Colors.white,
              width: double.infinity,
              child: CarouselSlider.builder(
                  key: _sliderKey,
                  unlimitedMode: true,
                  slideBuilder: (index) {
                    return FlatButton(
                      onPressed: () {
                        setState(() {
                          removeURL(urlList[index]);
                        });
                      },
                      child: Container(
                          height: 300,
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Stack(
                            children: <Widget>[
                              Image(
                                image: NetworkImage(imgList[index]),
                                fit: BoxFit.fitWidth,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Center(
                                    child: Text(
                                      productList[index] +
                                          " " +
                                          priceList[index] +
                                          "" +
                                          rateList[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                  slideTransform: CubeTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: 32),
                  ),
                  itemCount: imgList.length),
            ),
          ]),
        ),
      );
    }
  }
}
