import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  bool isSearch=false;
  final _formKey=GlobalKey<FormState>();
  String searched='';

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

  Submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print(searched);
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
              height: height*.12,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'IMGSY Home Facility',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                          onTap: (){
                            if(isSearch){
                              setState(() {
                                isSearch=false;
                              });
                            }
                            else{
                              setState(() {
                                isSearch=true;
                              });
                            }
                          },
                          child: Icon(isSearch?Icons.close:Icons.search,color: Colors.white,size:30,)),
                    ),
                  ],
                ),
              ),
            ),
            isSearch?Container(
              width: width,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Enter Search",
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (val) => searched = val.toString(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: Submit,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * .06,
                        decoration: BoxDecoration(
                          color: Colors.black87,
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
            ):Container(),
          ],
        ),
      ),


    );
  }
}
