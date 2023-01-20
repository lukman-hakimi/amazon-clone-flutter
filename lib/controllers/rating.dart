import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notes/models/rating.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../constants/http-error-handle.dart';
import '../constants/utils.dart';
import '../models/products.dart';
import '../providers/user.dart';
import 'package:http/http.dart' as http;

class RatingController {
  Future<Products> updateRating({
    required BuildContext context,
    required String productId,
    required double rating,
  }) async {
    Products product = Products(
        id: 'id',
        name: 'name',
        category: 'category',
        images: [],
        quantity: 12,
        price: 12,
        description: 'description',
        rating: [Rating(userId: '', id: 'id', rating: 23.0)]);
    try {
      Map<String, dynamic> postData = {
        "productId": productId,
        "rating": rating
      };

      http.Response res = await http.post(
          Uri.parse(kProductEndPoint + '/rating'),
          body: jsonEncode(postData),
          headers: {
            "content-type": "application/json",
            "auth": Provider.of<UserProvider>(context, listen: false).user.token
          });

      var data = jsonDecode(res.body)['data'];
      print(res.statusCode);
      httpErrorHandler(
          context: context,
          res: res,
          onSuccess: () {
            product = Products.fromJson(data);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return product;
  }
}
