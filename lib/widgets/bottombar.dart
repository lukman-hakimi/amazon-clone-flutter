import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/account.dart';
import 'package:notes/screens/home.dart';
import 'package:notes/screens/homescreen.dart';

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pageIndex = 0;
  List<Widget> pages = [
    Home(),
    AccountScreen(),
    Center(child: Text("cart page"),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        iconSize: 28,
        backgroundColor: Colors.white,
        onTap: (val) {
          setState(() {
            _pageIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _pageIndex == 0 ? Colors.green : Colors.white,
                      width: 5),
                ),
              ),
              child: Icon(Icons.home_outlined),
            ),
          ),

          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _pageIndex == 1 ? Colors.green : Colors.white,
                      width: 5),
                ),
              ),
              child: Icon(Icons.person_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _pageIndex == 2 ? Colors.green : Colors.white,
                      width: 5),
                ),
              ),
              child: Badge(
                elevation: 0,
                badgeContent: Text("3", style: TextStyle(fontSize: 17),),
                badgeColor: Colors.white,
                child: Icon(Icons.shopping_cart_outlined)),
            ),
          ),
        ],
      ),
    );
  }
}
