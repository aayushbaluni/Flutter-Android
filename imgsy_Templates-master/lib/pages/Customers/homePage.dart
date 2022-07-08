import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imgsy/pages/Customers/CustomerHomepage.dart';
import 'package:imgsy/pages/Customers/Notification.dart';
import 'package:imgsy/pages/Customers/Orders.dart';
import 'package:imgsy/pages/Customers/Profile.dart';
import 'package:imgsy/pages/Customers/Search.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class homePage extends StatefulWidget {
  final phone;
  const homePage({Key? key,required this.phone}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late PageController pageController;
  int pageIndex=0;
  final userRef = FirebaseFirestore.instance.collection('users');
  userData()async{
    final doc=await userRef.doc(widget.phone).get();
    print(doc['name']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController=PageController();
    userData();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    onTap(int pageIndex){
      pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,

      );
    }
    onPageChange(int pageIndex){
      setState(() {
        this.pageIndex =pageIndex ;});
    }
    final  List<TitledNavigationBarItem> items = [
      TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
      TitledNavigationBarItem(title: Text('Search'), icon: Icons.search),
      TitledNavigationBarItem(title: Text('Notification'), icon: Icons.add_alert),
      TitledNavigationBarItem(title: Text('Orders'), icon: Icons.shopping_cart),
      TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person_outline),
    ];
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          CustomerHomePage(),
          Search(),
          Notifications(),
          Orders(),
          Profile(phone: widget.phone,),
        ],
        onPageChanged: onPageChange,
      ),

      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) =>onTap(index),
        reverse: false,
        curve: Curves.easeInBack,
        items: items,
        activeColor: Colors.black,
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}
