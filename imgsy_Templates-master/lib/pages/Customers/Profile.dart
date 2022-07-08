import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final phone;
  const Profile({Key? key,required this.phone}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var info;
  bool searchEmail=false;
  bool isEmail=false;
   String email='';
  final key=GlobalKey<FormState>();
  final userRef = FirebaseFirestore.instance.collection('users');
  userData()async{
    final doc=await userRef.doc(widget.phone).get();
    setState(() {
      info=doc;
    });
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    SetEmail(){
      setState(() {
        searchEmail=true;
      });
    }
    UserEmail(){
      if(key.currentState!.validate()){
        key.currentState!.save();
        userRef.doc(widget.phone).update({
          'email':email
        }).whenComplete(() {
          userData();
          setState(() {
            isEmail=true;
          });
        });
      }
    }
    return Scaffold(

body: Container(
  height: height,
  width: width,
  color: Colors.white,
  child: Column(
    children: [
      Container(
        width: width,
        height: height*.11,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 25,
                      fontWeight:FontWeight.bold,
                  ),
                ),
                Icon(Icons.account_circle,size: 30,color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: height*0.81,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: height*0.2,
             decoration: BoxDecoration(
               border: Border.all(color: Colors.grey,width: 0.2,style: BorderStyle.solid),
               color: Colors.grey[200],
             ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
              info!=null?  info['name'].toString().toUpperCase():'',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          info!=null?  info['phone'].toString().toUpperCase():'',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        Text('   |  ',style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                        Text(
                          info!=null?  info['type'].toString().toUpperCase():'',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          ],
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: height*.610,
              color: Colors.white24,
              child:isEmail==false?GestureDetector(
                onTap: SetEmail,
                child: Column(
                  children: [
                    Container(
                      height: height*0.2,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        border: Border.all(color: Colors.black,width: 0.01)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Add Email',style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    searchEmail?Container(
                      height: height*0.1,
child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: MediaQuery.of(context).size.width * .7,
      child: Center(
        child: Form(
          key: key,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter Email",
              border: OutlineInputBorder(),
            ),
            onSaved: (val) => email = val.toString(),
          ),
        ),
      ),
    ),
    SizedBox(
      width: 10,
    ),
    GestureDetector(
      onTap: UserEmail,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * .06,
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: Center(
          child: Text(
            'Add',
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
                    ):SizedBox(),
                  ],
                ),
              ):Container(
                height: height*0.06,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.black,width: 0.01)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Text('Email',style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      Text(info['email'],style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),

            ),
          ],

        ),
      ),

    ],
  ),
),
    );
  }
}
