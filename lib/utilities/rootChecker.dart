import 'package:price_checker/utilities/product-scrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

rootChecker() async {
  try {
    print('got rootChecker');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('isReady');
    var listInt = prefs.getInt('listInt');
    print(listInt);
    print(boolValue);
    if (listInt == null) {
      boolValue = false;
    }
    if (boolValue != null) {
      if (boolValue != false) {
        String stringValue = prefs.getString('stringValue');
        getAttendance(stringValue);
      }
    }
  } catch (e) {
    print(e);
  }
}
