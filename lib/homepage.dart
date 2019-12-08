import 'package:digital_wallet/models/User.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/screens/add_screen.dart';
import 'package:digital_wallet/screens/home_screen.dart';
import 'package:digital_wallet/screens/notifications_screen.dart';
import 'package:digital_wallet/screens/profile_screen.dart';
import 'package:digital_wallet/screens/search_screen.dart';

class HomePage extends StatefulWidget {
  static final id = "home_screen";
  static User user;

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: <Widget>[
            Dashboard(),
            SearchScreen(),
            AddScreen(),
            NotifcationsScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: bottomItems(),
      ),
    );
  }

  BottomNavigationBar bottomItems() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        setState(
          () {
            currentIndex = index;
          },
        );
        pageController.animateToPage(
          index,
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeIn,
        );
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle,
            size: 35.0,
          ),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          title: SizedBox.shrink(),
        ),
      ],
    );
  }
}
