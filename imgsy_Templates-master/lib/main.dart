import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imgsy/pages/Customers/homePage.dart';
import 'package:imgsy/pages/Vendor/vendorsHomePage.dart';
import 'package:imgsy/utils/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = prefs.getString('phone');
  var type=prefs.getString('type');
  runApp(MyApp(phone: phone,type: type,));
}
class MyApp extends StatelessWidget {
  final phone;
  final type;
  const MyApp({Key? key,required this.phone,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.black,
          title: Text('IMGSY',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
          loaderColor: Colors.black,
          loadingText: Text('Welcome! Loading..',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          seconds: 4,
            navigateAfterSeconds: phone==null? Login():type=='Vendor'?vendorHomePage():homePage(phone: phone,),
        ),
      ),
    );
  }
}
