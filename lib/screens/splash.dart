// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mec_app/utilities/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// String routeKey = 'login';
// final _auth = FirebaseAuth.instance;
// bool isReady = false;

// class SplashScreen extends StatefulWidget {
//   SplashScreen();

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getReady();
//   }

//   void getReady() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     try {
//       isReady = prefs.getBool('isReady');
//       if (isReady == null) {
//         isReady = false;
//       }
//     } catch (e) {}
//     print(" ");
//     print(isReady);
//     print('');
//     if (isReady) {
//       final String userId = prefs.getString('username');
//       final String password = prefs.getString('password');
//       await _auth.signInWithEmailAndPassword(email: userId, password: password);
//       setState(() {
//         routeKey = 'home';
//       });
//     }
//     Navigator.pushNamed(context, routeKey);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(color: mainBgColor),
//             ),
//             Container(
//               color: mainBgColor,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     flex: 5,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 50),
//                       child: Center(
//                         child: CircleAvatar(
//                           backgroundColor: mainBgColor,
//                           backgroundImage: AssetImage('images/splash.png'),
//                           radius: 100.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Center(
//                           child: Text(
//                             "MEC APP",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 50,
//                               fontFamily: 'JosefinSans-Semi',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       )),
//                   Expanded(
//                       flex: 1,
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 20),
//                         child: Center(
//                           child: Text(
//                             "everything you need",
//                             style: TextStyle(
//                               color: Color(0xFF00DCA5),
//                               fontSize: 25,
//                               fontFamily: 'JosefinSlab-Bold',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       )),
//                   Expanded(
//                     flex: 1,
//                     child: SizedBox(
//                       height: 50,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
