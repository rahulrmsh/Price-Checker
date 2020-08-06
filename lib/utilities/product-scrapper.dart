import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getURL(stringKey) {
  var stringList = stringKey.toString().split('"');
  return (stringList[1]);
}

String rate;
getAttendance(stringKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('got inside getAttendance');
  var urlList = stringKey.toString().split('"');
  print(urlList);
  bool tryCompare;
  List<String> initialPriceList = [];
  try {
    String listValue = prefs.getString('listValue');
    if (listValue != null) {
      List bigList = listValue.split('"');
      for (var i = 0; i < bigList.length; i++) {
        List smallList = [];
        smallList.add(bigList[i].toString().split('+'));
        initialPriceList.add(smallList[0][1]);
      }
      tryCompare = true;
    }
  } catch (e) {
    tryCompare = false;
  }
  List finalList = [];
  for (var i = 0; i < urlList.length; i++) {
    try {
      List smallList = [];
      final response = await http.get(urlList[i]);
      var soup = Beautifulsoup(response.body);
      var spanList = soup.find(id: '#productTitle');
      var priceList = soup.find(id: "#priceblock_ourprice");
      var imageList = soup.find(id: "#landingImage");
      var imageURL = getURL(imageList.attributes['data-a-dynamic-image']);
      if (tryCompare) {
        rate =
            (int.tryParse(priceList.text) < int.tryParse(initialPriceList[i]))
                ? "decreased"
                : "increased";
      } else {
        rate = "First Entry";
      }
      smallList.addAll([spanList.text.trim(), priceList.text, imageURL]);
      finalList.add(smallList.join('+'));
    } catch (e) {
      return (0);
    }
  }
  prefs.setString('listValue', finalList.join('"'));
  print('finished loading');
}
