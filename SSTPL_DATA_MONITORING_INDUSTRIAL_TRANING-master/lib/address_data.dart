import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_one/address_detail.dart';

class ShowData extends StatefulWidget {
  final username;
  final password;
  final Address;
  const ShowData(
      {Key? key,
      required this.password,
      required this.username,
      required this.Address})
      : super(key: key);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Address: ${widget.Address}',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
              commonData(widget.Address, widget.username,
                  widget.password)), // i is null here (check periodic docs)
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return Container(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Time',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: items.size,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black45, width: 0.4),
                                    color: Colors.white24),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {

                                        Alert(
                                          title: "Time:  "+ snapshot.data[index]['time'],
                                          content: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("MAC:  "+
                                                  snapshot.data[index]['MAC'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text("Freq:  "+
                                                snapshot.data[index]['freq'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "SF:  "+
                                                snapshot.data[index]['Date_Rate'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text("RSSI: "+
                                                snapshot.data[index]['RSSI'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text('SNR:  '+
                                                snapshot.data[index]['LORA_SNR'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text('PAYLOAD:  '+
                                                  snapshot.data[index]['PAYLOAD'],
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),

                                            ],
                                          ), context: context,
                                        ).show();
                                      },
                                      child: Container(
                                          alignment: Alignment.topLeft,
                                          color: index % 2 == 0
                                              ? Colors.grey[200]
                                              : Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Text(
                                                snapshot.data[index]['time'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
              );
            } else {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  ),
                ),
              );
            }
          }, // builder should also handle the case when data is not fetched yet
        ),
      ),
    );
  }
}

Future commonData(String Adress, String username, String password) async {
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  Response response = await get(
      Uri.parse('API_'),
      headers: <String, String>{'authorization': basicAuth});
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var records = mutableListFrom(json['records']);
    records.forEach((element) {
      if (Adress.toString() != element['Address']) {
        records.remove(element);
      }
      print(records);
    });
    return records;
  } else {
    throw Exception('Failed to load Data.');
  }
}
