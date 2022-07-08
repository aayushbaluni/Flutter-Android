import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_one/address_data.dart';
import 'package:table_one/login.dart';
import 'package:table_one/search_address.dart';

class Mains extends StatefulWidget {
  final username;
  final password;

  const Mains({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _MainsState createState() => _MainsState();
}

class _MainsState extends State<Mains> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    "All Addresses",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .05,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                    username: widget.username,
                                    password: widget.password)));
                      },
                      child: Container(
                        child: Text(
                          'Search By Address?Tap me!',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.height * .02,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: ()async{
                          SharedPreferences preference=await SharedPreferences.getInstance();
                          preference.remove('username');
                          preference.remove('password');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Container(
                           child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.height * .02,
                              fontWeight: FontWeight.bold),
                        ),
                        ))
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                    getData(
                        widget.username,
                        widget
                            .password)), // i is null here (check periodic docs)
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data;
                    return Container(
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: items.size,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: 0.4),
                                          color: Colors.white24),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowData(
                                                        username:
                                                        widget.username,
                                                        password:
                                                        widget.password,
                                                        Address: snapshot
                                                            .data[index]
                                                        ['Address'],
                                                      )));
                                        },
                                        child: Container(
                                          color:index%2==0?Colors.grey[200]:Colors.white,
                                            child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            snapshot.data[index]['Address'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * .8,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                      ),
                    );
                  }
                }, // builder should also handle the case when data is not fetched yet
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Future<KtList<dynamic>> getData(String username, String password) async {
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  Response response = await get(
      Uri.parse('API_'),
      headers: <String, String>{'authorization': basicAuth});
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var records = mutableListFrom(json['records']);
    var distinct = records.distinctBy((it) => it["Address"]);
    return distinct;
  } else {
    throw Exception('Failed to load Data.');
  }
}
