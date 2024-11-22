import 'package:ecommapp/screens/cartscreen.dart';
import 'package:ecommapp/screens/detailscreen.dart';
import 'package:ecommapp/screens/homescreen.dart';
import 'package:ecommapp/screens/profilescreen.dart';
import 'package:flutter/material.dart';

class NavifationPage extends StatefulWidget {
  @override
  State<NavifationPage> createState() => _NavifationPageState();
}

class _NavifationPageState extends State<NavifationPage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    DetailPage(),
    CartScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Show the FAB only on the HomePage
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: const Color(0xFFFF660E),
              onPressed: () {},
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            )
          : null, // Hide the FAB on other pages
      bottomNavigationBar:
          currentIndex == 0 // Only show BottomNavigationBar on HomePage
              ? BottomAppBar(
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
                )
              : null, // Don't show BottomNavigationBar on other pages
    );
  }
}
