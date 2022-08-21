import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Future<String> getdata() async {
  Response response =
      await http.get(Uri.parse('http://www.boredapi.com/api/activity/'));
  var data = jsonDecode(response.body);
  print(response.statusCode);
  print(data['activity']);
  return data['activity'] as String;
}

String text = "";
var isTrue = true;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Center(
              child: Container(
                height: height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "ARE YOU BORED??",
                    style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: width * 0.06)),
                  ),
                ),
              ),
            ),
            isTrue == true
                ? SizedBox(
                    height: 20,
                  )
                : Center(
                    child: Center(
                      child: Container(
                          width: width * 0.5,
                          child: Center(
                              child: Text(
                            text,
                            style: GoogleFonts.actor(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05)),
                          ))),
                    ),
                  ),
            SizedBox(),
            Center(
              child: GestureDetector(
                onTap: () async {
                  isTrue = false;
                  text = await getdata() as String;
                  setState(() {});
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Center(
                    child: Text(
                      "Get Activity",
                      style: GoogleFonts.damion(
                          textStyle: TextStyle(
                              color: Colors.white, fontSize: width * 0.043)),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Developed for you by us",
                    style: GoogleFonts.babylonica(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
