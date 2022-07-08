import 'package:ai_radio/pages/HomePage.dart';
import 'package:ai_radio/pages/Affirmations.dart';
import 'package:ai_radio/pages/Inspirational.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
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
      home:  Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.purple[900],
          title: Text('Welcome.',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
          loaderColor: Colors.white,
          loadingText: Text('Loading...',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          seconds: 2,
          navigateAfterSeconds: HomePage(),
        ),
      ),
    );
  }
}
