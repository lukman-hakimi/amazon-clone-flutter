import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/providers/user.dart';
import 'package:notes/widgets/posts-screen.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _indexPage = 0;
  List pages = [
    PostsScreen(),
    Text("images"),
    Text("ho"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff7FE9DE), Color(0xff7FE9DE)],
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Image(
                  image: AssetImage("assets/images/amazon_in.png"),
                  width: 120,
                  color: Colors.black,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    "Admin",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
      ),

      // body
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: pages[_indexPage]),

      // bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexPage,
        iconSize: 28,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _indexPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        ],
      ),
    );
  }
}
