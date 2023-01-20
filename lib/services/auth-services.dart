import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/constants/constants.dart';
import 'package:notes/constants/http-error-handle.dart';
import 'package:notes/constants/utils.dart';
import 'package:notes/providers/user.dart';
import 'package:notes/screens/admin.dart';
import 'package:notes/screens/home.dart';
import 'package:notes/widgets/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  signUp(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password
    };

    try {
      http.Response res = await http.post(
          Uri.parse(kUserEndPoint + "/register"),
          body: jsonEncode(data),
          headers: {"content-type": "application/json"});

      httpErrorHandler(
          context: context,
          res: res,
          onSuccess: () {
            showSnackBar(context, "Account seccesfuly created!!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    Map<String, dynamic> data = {"email": email, "password": password};

    http.Response res = await http.post(Uri.parse(kUserEndPoint + '/login'),
        body: jsonEncode(data), headers: {"content-type": "application/json"});

    httpErrorHandler(
        context: context,
        res: res,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          if (Provider.of<UserProvider>(context, listen: false).user.type ==
              "admin") {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AdminScreen()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BottomBar()));
          }
        });
  }

  getUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("x-auth-token");

    if (token == null) {
      await prefs.setString('x-auth-token', '');
    }

    http.Response tokenRes = await http.post(
        Uri.parse(kUserEndPoint + '/isTokenValid'),
        headers: {"content-type": "application/json", "auth": token!});

    var response = jsonDecode(tokenRes.body)['msg'];

    if (response == true) {
      http.Response userRes =
          await http.get(Uri.parse(kUserEndPoint), headers: {"auth": token});

      Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
    }
  }
}
