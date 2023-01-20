import 'dart:convert';
import "dart:io";
import 'package:cloudinary_public/cloudinary_public.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:notes/constants/constants.dart';
import 'package:notes/constants/http-error-handle.dart';
import 'package:notes/constants/utils.dart';
import 'package:notes/models/products.dart';
import 'package:notes/models/rating.dart';
import 'package:notes/providers/user.dart';
import 'package:provider/provider.dart';

class AdminController {
  void sellProduct({
    required String name,
    required String description,
    required double quantity,
    required double price,
    required String category,
    required BuildContext context,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dhei2eo7r", "vj3qxbnf");
      List<String> imagesUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrl.add(res.secureUrl);
      }

      Products product = Products(
          id: '',
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          category: category,
          images: imagesUrl,
          rating: [Rating(userId: '', id: '', rating: 6.0)]);

      http.Response res =
          await http.post(Uri.parse(kAdminEndPoint + '/addProducts'),
              body: jsonEncode({
                "name": product.name,
                "description": product.description,
                "quantity": product.quantity,
                "price": product.price,
                "category": product.category,
                "images": product.images
              }),
              headers: {
            "content-type": "application/json",
            "auth": Provider.of<UserProvider>(context, listen: false).user.token
          });

      print(jsonDecode(res.body));

      httpErrorHandler(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Products>> getProducts({required BuildContext context}) async {
    List<Products> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse(kAdminEndPoint + '/getProducts'), headers: {
        "auth": Provider.of<UserProvider>(context, listen: false).user.token
      });

      final List data = jsonDecode(res.body)['data'];

      print("before");

      productList = data.map((e) {
        return Products.fromJson(e);
      }).toList();

      print("after");

      httpErrorHandler(context: context, res: res, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }

    return productList;
  }

  void deleteProduct(
      {required BuildContext context, required String id}) async {
    try {
      http.Response res = await http.delete(Uri.parse(kAdminEndPoint + '/$id'),
          headers: {
            "auth": Provider.of<UserProvider>(context, listen: false).user.token
          });

      httpErrorHandler(
          context: context,
          res: res,
          onSuccess: () {
            showSnackBar(context, jsonDecode(res.body)['msg']);
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
