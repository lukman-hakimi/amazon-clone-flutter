import 'dart:convert';

import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/http-error-handle.dart';
import '../constants/utils.dart';
import '../models/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/user.dart';

class SearchController {
  Future<List<Products>> searchProducts(
      {required BuildContext context, required String searchQuery}) async {
    List<Products> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(kProductEndPoint + '/search/$searchQuery'),
        headers: {
          "auth": Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );

      final List data = jsonDecode(res.body)['data'];

      httpErrorHandler(
        context: context,
        res: res,
        onSuccess: () {
          productList = data.map((e) {
            return Products.fromJson(e);
          }).toList();
        },
      );
      
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return productList;
  }
}
