import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/constants/http-error-handle.dart';
import 'package:notes/constants/utils.dart';
import 'package:notes/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:notes/providers/user.dart';
import 'package:provider/provider.dart';

class HomeController {
  Future<Products> getDealOfDay(BuildContext context) async {
    Products products = Products(
        id: 'id',
        name: 'name',
        category: 'category',
        images: [],
        quantity: 0,
        price: 0,
        description: 'description',
        rating: []);

    try {
      http.Response res = await http
          .get(Uri.parse(kProductEndPoint + '/deal-of-day'), headers: {
        "auth": Provider.of<UserProvider>(context, listen: false).user.token
      });

      // print(res.body);
      Map<String, dynamic> data = jsonDecode(res.body)['data'];

      httpErrorHandler(
        context: context,
        res: res,
        onSuccess: () {
          products = Products.fromJson(data);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }
}
