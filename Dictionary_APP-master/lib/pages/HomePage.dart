import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owlbot_dart/owlbot_dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  bool notSearched = false;
  String word = '';
  Future<OwlBotResponse?> Submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final OwlBot owlBot =
          OwlBot(token: '53e7d74da2e5ae1d7b6dac939c7e7e74a7dccb71');
      OwlBotResponse? response = await owlBot.define(word: word.toString());
      if (response != null) {
        print(response.pronunciation);
        response.definitions!.forEach((element) {
          print(element.definition);
        });
        return response;
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text(
            'Dictionary',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 10.0),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Center(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Word",
                                  hintText: "Enter the Word",
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (val) => word = val.toString(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Submit();

                            setState(() {
                              notSearched = true;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * .06,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                            ),
                            child: Center(
                              child: Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: notSearched
                        ? FutureBuilder(
                            future: Submit(),
                            builder: (context,
                                AsyncSnapshot<OwlBotResponse?> snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Text(
                                            snapshot.data!.word.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0,
                                              left: 9.0,
                                              bottom: 12.0),
                                          child: Text(
                                            'Pronunciation: ${snapshot.data!.pronunciation}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:Text("Define: "+snapshot.data!.definitions!.map((e) => e.definition).toString(),style: TextStyle(color: Colors.black,fontSize: 20),),

                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.teal,
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      'Try checking the word is from dictionary.',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              'Type to Search',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                  ),
                ]))));
  }
}
