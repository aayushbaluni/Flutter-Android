import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Configuration.dart';
import 'Screen2.dart';
import 'Screen3.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isopen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 10000,
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(scalefactor),
      duration: Duration(milliseconds: 350),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:isopen? BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20) ):BorderRadius.all(Radius.zero),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isopen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xoffset = 0;
                              yoffset = 0;
                              scalefactor = 1;
                              isopen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xoffset = 230;
                              yoffset = 150;
                              scalefactor = 0.6;
                              isopen = true;
                            });
                          },
                        ),
                  Column(
                    children: [
                      Text("Location"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on,
                                color: primarycolor,
                              )),
                          Text("India"),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60.0,vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                  prefixIcon: Icon(Icons.search),
                    hintText: "Type to Search",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primarycolor),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primarycolor),
                    borderRadius:BorderRadius.all(Radius.circular(30))
                  ),

                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          padding: EdgeInsets.all(10),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: styleshadow,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Image.asset(categories[index]['iconPath']),
                        ),
                        Text(categories[index]['name']),
                      ],
                    ),
                  );
                },
              ),

            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen()));
              },
              child: Container(
                height: 250,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(

                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children:[
                          Container(
                            decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(20),boxShadow: styleshadow),
                            margin: EdgeInsets.only(top: 45),
                          ),
                            Align(
                              child: Image.asset('images/cat2.png'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container(
                        height: 250,
                        margin: EdgeInsets.only(top: 65,bottom: 20),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(20) ,bottomRight: Radius.circular(20)),boxShadow: styleshadow),
                        child: Text('Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      )),
                    ],
                  ),
                ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen3()));
              },
              child: Container(
                height: 250,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(

                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children:[
                          Container(
                            decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.circular(20),boxShadow: styleshadow),
                            margin: EdgeInsets.only(top: 45),
                          ),
                          Align(
                            child: Image.asset('images/cat1.png'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      height: 250,
                      margin: EdgeInsets.only(top: 65,bottom: 20),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(20) ,bottomRight: Radius.circular(20)),boxShadow: styleshadow),
                      child: Text('Name-2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    )),
                  ],
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
