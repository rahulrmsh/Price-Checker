import 'package:price_checker/utilities/product-scrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

rootChecker() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('isReady');
    if (boolValue != null && boolValue != false) {
      String stringValue = prefs.getString('stringValue');
      getAttendance(stringValue);
    }
  } catch (e) {
    print(e);
  }
}
