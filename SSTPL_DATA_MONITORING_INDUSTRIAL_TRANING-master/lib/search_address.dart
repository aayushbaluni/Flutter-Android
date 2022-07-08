import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';
import 'package:table_one/address_data.dart';

class Search extends StatefulWidget {
  final username;
  final password;
  const Search({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  bool notSearched = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    String? Address;




    SearchAddress(String username, String password) async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        print(Address);
        String basicAuth =
            'Basic ' + base64Encode(utf8.encode('$username:$password'));
        Response response= await get(Uri.parse('API_'),
            headers: <String, String>{'authorization': basicAuth});
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          var records = mutableListFrom(json['records']);
          records.forEach((element) {
            if(Address.toString()!=element['Address']){
              records.remove(element);
            }

          });
        var distinct=records.distinctBy((it) => it['Address']);
          print(distinct);
          return distinct;

        } else {
          throw Exception('Failed to load Data.');
        }

      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search By Address',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
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
                              labelText: "Address",
                              hintText: "Enter Address",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (val) => Address = val.toString(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          notSearched = false;
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
              notSearched
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Type to Search',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    )
                  :SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 5)).asyncMap((i) =>
                      SearchAddress(
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
                                        child: Container(
                                          color: index%2==0?Colors.grey[200]:Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: GestureDetector(
                                                  onTap: () {
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
                                                  child: Text(
                                                    snapshot.data[index]['Address'],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                            )),
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
            ]
          )
        )
      )
    );

  }
}




