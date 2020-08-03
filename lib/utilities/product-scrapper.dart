import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getURL(stringKey) {
  var stringList = stringKey.toString().split('"');
  return (stringList[1]);
}

getAttendance(stringKey) async {
  var urlList = stringKey.toString().split('"');
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
      smallList.addAll([spanList.text.trim(), priceList.text, imageURL]);
      finalList.add(smallList.join('+'));
    } catch (e) {
      return (0);
    }
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('listValue', finalList.join('"'));
}
