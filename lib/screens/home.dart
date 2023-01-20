import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/models/note.dart';
import 'package:notes/providers/user.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import './screen.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  

  Future<List<Note>> getNotes() async {
    List<Note> noteModel = [];
    try {
      http.Response res = await http.get(Uri.parse(kEndPoint+"/notes"));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        List latestData = data["data"];

        noteModel = latestData.map((e) => Note.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
    }

    return noteModel;
  }

  Future<List> test() async {
    var test = [] ;
    try {
      http.Response res = await http.get(Uri.parse(kEndPoint+"/notes"));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        List latestData = data["data"];

        List test = latestData;
      }
    } catch (e) {
      print(e.toString());
    }

    print(test);
    return test;
  }

 
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).user;
    getNotes();
    return Scaffold(
      // appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "${userData.token}",
          style: TextStyle(color: Colors.black54, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),

      // body
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                children: [
                  // textField
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          border: InputBorder.none,
                          hintText: "search note...",
                          hintStyle: TextStyle(fontSize: 20),
                          suffixIcon: Icon(Icons.search),
                          filled: true,
                          labelText: "somethinf..."),
                    ),
                  ),

                  // ListView
                  Expanded(
                    child: FutureBuilder<List>(
                      future: test(),
                      builder: (context, snapshoot) {
                        // snapshoot wuxu ino hayaaa xogtene
                        switch (snapshoot.connectionState) {
                          // snapshoot.connectionState wuxu checking ku sameynaya xalada xogta
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            if (snapshoot.hasData) {
                              if (snapshoot.data != null) {
                                return ListView.builder(
                                  itemCount: snapshoot.data!.length,
                                  itemBuilder: (context, index) {
                                    return BodyConatainer(
                                      noteModal: snapshoot.data![index],
                                    );
                                  },
                                );
                              }
                            }
                        }
                        throw "hi";
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // RawMaterialButton(
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
          //   },
          //   fillColor: Colors.red,
          //   constraints:
          //       BoxConstraints.tightFor(width: double.infinity, height: 50),
          //   child: Text(
          //     "Regsiter",
          //     style: TextStyle(
          //         fontSize: 20, letterSpacing: 1, color: Colors.white),
          //   ),
          // )
        ],
      ),
    );
  }
}
