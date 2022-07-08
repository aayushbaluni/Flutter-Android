import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imgsy/pages/Customers/homePage.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String phone;
 late  String sms;
   bool IsSMS=false;
  final GlobalKey<ScaffoldState> _scaffolkey= GlobalKey<ScaffoldState>();
  late String _varificationcode;
  final TextEditingController _pinPutController=TextEditingController();
  final FocusNode _pinPutFoucus =FocusNode();
  final BoxDecoration pinPutdecoration=BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      )
  );
  final formkey=GlobalKey<FormState>();
  _verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phone}',
        verificationCompleted: (PhoneAuthCredential credential) async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
            if(value.user!=null){
              SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
              sharedPreferences.setString('phone', phone);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homePage(phone: value.user!.phoneNumber,)),
                      (route) => false);
            }

          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verficationID,int? resendToken){
          setState(() {
            _varificationcode=verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID){
          setState(() {
            _varificationcode=verificationID;
          });
        },
        timeout: Duration(seconds: 120)

    );
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
Submit(){
  if(formkey.currentState!.validate()){
    formkey.currentState!.save();
    _verifyPhone();
    setState(() {
      IsSMS=true;
    });
  }
}
    return Scaffold(
      body:Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(top: height*0.3),
            height: height,
            width: width,
            color: Colors.black87,
          ),
          Container(
            margin: EdgeInsets.only(top: height*0.7),
            height: height,
            width: width,
            color: Colors.white,
          ), Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(top: height*0.15,bottom: height*0.15,left: width*0.1,right: width*0.1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black12,width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 6,
                  blurRadius: 25,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: height*.15,
                      decoration: BoxDecoration(
                       shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage('assets/logo.PNG'),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      child: Text("Welcome to IMGSY.",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold  ),),
                    ),
                    SizedBox(height: 40,),
                    Text('LOGIN.',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 35),),

                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formkey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Phone",
                            hintText: "Enter your Number",
                            border: OutlineInputBorder(
                            ),
                            focusColor: Colors.black,
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(
                              Icons.phone,
                              size: 30.0,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          onSaved: (val) => phone = val.toString(),
                          autovalidate: true,
                          validator: (val){
                            if(val!.length<10){
                              return "Length too short";
                            }
                            if(val.length>10){
                              return "Length too long";
                            }
                          },
                        ),
                    ),
                    SizedBox(
                      height: 40,
                    ),IsSMS? Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: PinPut(
                        fieldsCount: 6,

                        textStyle: const TextStyle(fontSize: 25.0,color: Colors.white),
                        eachFieldWidth: 40.0,
                        eachFieldHeight: 55.0,
                        focusNode: _pinPutFoucus,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutdecoration,
                        selectedFieldDecoration: pinPutdecoration,
                        followingFieldDecoration: pinPutdecoration,
                        pinAnimationType: PinAnimationType.fade,
                        onSubmit: (pin)async{
                          try{
                            await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _varificationcode, smsCode: pin)).
                            then((value) async{
                              if (value.user!=null){
                                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                sharedPreferences.setString('phone', phone);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homePage(phone: phone,)), (route) => false);
                              }
                            });
                          }
                          catch(e){
                            FocusScope.of(context).unfocus();
                            _scaffolkey.currentState!.showSnackBar(SnackBar(content: Text("invalid OTP"),));
                          }
                        },



                      ),
                    ):SizedBox(height: 15,),
                    GestureDetector(
                      onTap:Submit,
                      child: Container(
                        height: height*0.08,
                        width: width*0.3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            IsSMS?"Verify":'Proceed ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}
