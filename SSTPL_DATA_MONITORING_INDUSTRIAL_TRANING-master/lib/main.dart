import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:table_one/all_address.dart';
import 'package:table_one/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  var password = prefs.getString('password');
  print(username);
  runApp(MyApp(username: username,password: password,));
}

class MyApp extends StatelessWidget {
  final username;
  final password;
  const MyApp({Key? key,required this.username,required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          title: Text(
            "Welcome to SSTPL",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          image: Image(image: AssetImage('assests/sstpllogo.png'),),
          photoSize: 200,
          loadingText: Text(
            'loading..',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          loaderColor: Colors.teal,
          seconds: 5,
          navigateAfterSeconds: username==null?Login():Mains(username: username, password: password),
        ),
      ),
    );
  }
}
