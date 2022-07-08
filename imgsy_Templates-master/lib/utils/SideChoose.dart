import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imgsy/pages/Customers/CustomerHomepage.dart';
import 'package:imgsy/pages/Customers/homePage.dart';
import 'package:imgsy/pages/Vendor/vendorsHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  final phone;
  const HomePage({Key? key, required this.phone}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = GlobalKey<FormState>();
  String name = '';
  bool isName = true;
  String type = '';
  final userRef = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {

    Verify() async {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        userRef.doc(widget.phone).set({
          'phone': widget.phone,
          'name': name,
          "type":type,
          'email':'',
        }).whenComplete(() async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('phone', widget.phone);
          prefs.setString('type', type);
          if(type=='Vendor'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>vendorHomePage()));
          }if(type=='Customer'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage(phone: widget.phone)));
          }
        });
      }}
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

      return Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                  height: height * 0.5,
                  width: width,
                  color: Colors.black,
                  child: Image(
                    image: AssetImage(
                      'assets/logo.PNG',
                    ),
                    height: height * .4,
                    width: width * 0.6,
                  )),
              Container(
                margin: EdgeInsets.only(top: height * 0.45),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          "Welcome To The IMGSY's Engineering World.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isName
                            ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              GestureDetector(
                                onTap: () async {
                                  final doc =
                                  await userRef.doc(widget.phone).get();
                                  if (!doc.exists) {
                                    setState(() {
                                      isName = false;
                                      type = 'Vendor';
                                    });
                                  }else{
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>vendorHomePage()));
                                  }
                                },
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 30,
                                            spreadRadius: 5)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            'assets/vender.PNG',
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                "Vendor Login",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                            Text(
                                              'Proceed to SignIN/SignUP',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final doc =
                                  await userRef.doc(widget.phone).get();
                                  if (!doc.exists) {
                                    setState(() {
                                      isName = false;
                                      type = 'Customer';
                                    });
                                  }else{
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerHomePage()));
                                  }
                                },
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 30,
                                            spreadRadius: 5)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            'assets/customer.jpg',
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                'Customer Login',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            Text(
                                              'Proceed to SignIN/SignUP',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                            )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                child: Form(
                                    key: key,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        hintText: "Enter your Name",
                                        border: OutlineInputBorder(
                                        ),
                                        focusColor: Colors.black,
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      onSaved: (val) => name = val.toString(),
                                    )),
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: Verify,
                                child: Container(
                                  height: height * 0.08,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Proceed ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          'Please choose a side to continue  -->',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }