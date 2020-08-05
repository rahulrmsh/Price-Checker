import 'package:shared_preferences/shared_preferences.dart';

removeURL(stringKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String listValue = prefs.getString('stringValue');
  var listInt = prefs.getInt('listInt');
  print(listInt);
  print(listValue);
  List<String> initialList = listValue.split('"');
  List<String> finalList = [];
  for (var i = 0; i < initialList.length; i++) {
    if (initialList[i] == stringKey) {
      listInt = listInt - 1;
      if (listInt <= 0) {
        listInt = 0;
        prefs.setBool('isReady', false);
      }
    } else {
      finalList.add(initialList[i]);
    }
  }
  prefs.setString('stringValue', finalList.join('"'));
  prefs.setInt('listInt', listInt);
  print(listInt);
}
