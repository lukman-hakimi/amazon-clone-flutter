import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/constants/constants.dart';
import 'package:notes/constants/http-error-handle.dart';
import 'package:notes/constants/utils.dart';
import 'package:notes/models/products.dart';
import 'package:notes/providers/user.dart';
import 'package:provider/provider.dart';

class CategoryDealsController {
  Future<List<Products>> getCategoryDeals({
    required BuildContext context,
    required String category,
  }) async {
    List<Products> product = [];
    try {
      http.Response res = await http.get(
        Uri.parse(kProductEndPoint + '/productCategory?category=$category'),
        headers: {
          'auth': Provider.of<UserProvider>(context, listen: false).user.token,
        },
      );
      List data = jsonDecode(res.body)['data'];
      // print(data);

      httpErrorHandler(
        context: context,
        res: res,
        onSuccess: () {
          product = data.map((e) {
            return Products.fromJson(e);
          }).toList();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print("product $product");
    return product;
  }
}
