import 'package:shared_preferences/shared_preferences.dart';

removeURL(stringKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String listValue = prefs.getString('stringValue');
  var listInt = prefs.getInt('listInt');
  print(listInt);
  List<String> initialList = listValue.split('"');
  List<String> finalList = [];
  for (var i = 0; i < initialList.length; i++) {
    if (initialList[i] != stringKey) {
      finalList.add(initialList[i]);
    } else {
      listInt = listInt - 1;
    }
  }
  prefs.setString('stringValue', finalList.join('"'));
  prefs.setInt('listInt', listInt);
  print(listInt);
}
