import 'package:ecommapp/screens/dashboard/nav_pages/cart/cartscreen.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/homescreen.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/profilescreen.dart';
import 'package:flutter/material.dart';

class NavifationPage extends StatefulWidget {
  @override
  State<NavifationPage> createState() => _NavifationPageState();
}

class _NavifationPageState extends State<NavifationPage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    CartScreen(),
    CartScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Show the FAB only on the HomePage
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: const Color(0xFFFF660E),
        onPressed: () {
          setState(() {
            currentIndex = 0;
          });
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12.0,
        elevation: 11,
        shadowColor: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_outline),
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
            SizedBox(width: 40), // Space for the FAB
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
