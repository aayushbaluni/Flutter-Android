import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'all_address.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? username;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String? password;
    Submit() async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
      }
      print("Entered : ${username}, ${password} ");

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      Response response = await http.get(
          Uri.parse('API_'),
          headers: <String, String>{'authorization': basicAuth});
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('username', username.toString());
        preferences.setString('password', password.toString());
        final snackbar = SnackBar(content: Text("Welcome $username"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Mains(
                    username: username,
                    password: password,
                  )),
          result: (Route<dynamic> route) => false,
        );
      }
      if (response.statusCode == 401) {
        final snackbar = SnackBar(content: Text(response.body));
        return ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        return CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.white10,
        );
      }
    }

    notAuth() {
      return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Colors.blue[50]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.6,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 15.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(image: AssetImage('assests/sstpllogo.png'),height: 120,width: 250,),
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),

                        //for invalid credentials

                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  hintText: "Enter your username",
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(
                                    Icons.alternate_email_rounded,
                                    size: 30.0,
                                  ),
                                ),
                                onSaved: (val) => username = val.toString(),
                              ),
                              SizedBox(
                                height: 60.0,
                              ),
                              TextFormField(
                                obscureText: true,
                                onSaved: (val) => password = val.toString(),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your Password',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: Submit,
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      );
    }

    return notAuth();
  }
}

//after login screen
