import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class Inspirational extends StatefulWidget {
  const Inspirational({Key? key}) : super(key: key);

  @override
  _InspirationalState createState() => _InspirationalState();
}

class _InspirationalState extends State<Inspirational> {
  @override
  Widget build(BuildContext context) {

    Future<Map> getData() async{
     Response response = await http.get(Uri.parse('https://www.affirmations.dev/'));
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
              Center(child: Text('Affirmations For You.',style: GoogleFonts.abel(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),)),
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0,left: 10),
                              child: Text(snapshot.data!['affirmation'],style:GoogleFonts.aBeeZee(color: Colors.purple[900],fontSize: 40),),
                            ),
                          ],
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
