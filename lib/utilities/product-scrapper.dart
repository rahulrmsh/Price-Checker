import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:http/http.dart' as http;

// class GetData {
//   getTableRow(tableList, row) {
//     try {
//       var tableListdoc = Beautifulsoup(tableList);
//       var tablerows2 =
//           tableListdoc.find_all("tr").map((e) => (e.outerHtml)).toList();
//       var tablerows = '';
//       if (tablerows2.length > row)
//         tablerows = tablerows2[row];
//       else
//         tablerows = '';
//       var tabledoc = Beautifulsoup(tablerows).get_text();
//       var tabledoclist = tabledoc.split('\n');
//       for (int i = 0; i < tabledoclist.length; i++)
//         tabledoclist[i] = tabledoclist[i].trim();
//       tabledoclist.removeWhere((value) => value == '');
//       return tabledoclist;
//     } catch (e) {
//       return (0);
//     }
//   }
getURL(stringKey) {
  var stringList = stringKey.toString().split('"');
  return (stringList[1]);
}

getAttendance() async {
  var urlList = [
    'https://www.amazon.in/Sony-WH-CH400-Wireless-Headphones-Black/dp/B07BXXXQKQ/ref=pd_di_sccai_2/262-6853295-3598216?_encoding=UTF8&pd_rd_i=B07BXXXQKQ&pd_rd_r=2e502662-997f-4c15-88a7-2c23a6103d6a&pd_rd_w=DFPP7&pd_rd_wg=GlT3L&pf_rd_p=a1f3aa5a-f05d-4e2d-b84b-6ef88e21fb7e&pf_rd_r=WXDF7XSNY56CVMX3D8AG&psc=1&refRID=WXDF7XSNY56CVMX3D8AG',
    'https://www.amazon.in/Sony-MDR-ZX330BT-Bluetooth-Headphones-Black/dp/B00YMUD8JY?pf_rd_r=G67DJJYGJQ1RD079JBMX&pf_rd_p=cf2644f2-1964-492d-94e4-e624f0d9f42e&pd_rd_r=b8bfe074-b616-4d05-96f4-827824e9b25d&pd_rd_w=SVvOy&pd_rd_wg=mQQIx&ref_=pd_gw_ci_mcx_mr_hp_d'
  ];
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
      print("Name : " +
          spanList.text.trim() +
          "\nPrice : " +
          priceList.text +
          "\nURL : " +
          imageURL +
          "\n\n");
      finalList.add(smallList);
      //   var studentattendance = getTableRow(tableList[0], classNo + 1);
      //   if (studentattendance.length != 0) studentattendance.removeAt(0);
      //   if (studentattendance.length != 0) studentattendance.removeAt(0);
      //   var firstrow = getTableRow(tableList[0], 0);
      //   if (firstrow.length != 0) firstrow.removeAt(0);
      //   if (firstrow.length != 0) firstrow.removeAt(0);
      //   for (var i = 0; i < firstrow.length; i++) {
      //     firstrow[i] = firstrow[i].split('(')[0];
      //   }
      //   final finalMap = Map<String, String>();
      //   for (var i = 0; i < firstrow.length; i++) {
      //     finalMap.putIfAbsent(firstrow[i], () => studentattendance[i]);
      //   }
      //   print(finalMap);
      // return (finalMap);
    } catch (e) {
      return (0);
    }
  }
  print(finalList);
}
