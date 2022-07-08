import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  Widget build(BuildContext context) {

    Future<Map> getData() async{
      Response response = await http.get(Uri.parse('https://api.fisenko.net/quotes?l=en'));
      var data=jsonDecode(response.body) as Map;
      return data;
    }
    var affirmation;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.purple[900],
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: Text('Inspirational Quotes For  Better You!',style: GoogleFonts.abel(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),)),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height*.6,
                  width: MediaQuery.of(context).size.width*.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context,AsyncSnapshot<Map>snapshot){
                      if(snapshot.hasData){
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0,left: 10),
                                child: Text(snapshot.data!['text'],style:GoogleFonts.aBeeZee(color: Colors.purple[900],fontSize: 40),),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text('By: ${snapshot.data!['author']}',style: GoogleFonts.abel(color: Colors.purple[700],fontSize: 20),),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple[900],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState(() {

                        });
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Text('Next',style: TextStyle(color: Colors.purple[900],fontSize: 40,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
