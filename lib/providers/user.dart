import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/models/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(email: '', id: '', name: '', password: '', token: '', type: '');

  User get user => _user;

  void setUser(String data){
    _user = User.fromJson(jsonDecode(data));
    notifyListeners();
  }
}