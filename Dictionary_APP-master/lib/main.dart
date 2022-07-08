import 'package:dictionary_app/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.black,
          loaderColor: Colors.white,
          title: Text('Dictionary.',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40
          ),),
          loadingText:Text('By Ayush Baluni.',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          seconds: 3,
          navigateAfterSeconds: HomePage(),
        ),
      ),
    );
  }
}
