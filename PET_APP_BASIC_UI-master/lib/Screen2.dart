import 'package:flutter/material.dart';
import 'HomePage.dart';
class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child:Column(
                children: <Widget>[
                  Expanded(child:Stack(
                  children: [
                    Container(
                      color: Colors.blueGrey,
                    ),
                    Align(

                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             IconButton(onPressed: (){
                               Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,)),
                             IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.white,))

                           ],
                         ),


                      ),
                    ),Align(
                      child: Image.asset('images/cat2.png'),
                    )

                  ],
                  )
                  ),
                  Expanded(child: Container(
                    color: Colors.white,
                  ))
                  ],
              ) ,
          ),
        ],
      ),
    );
  }
}
