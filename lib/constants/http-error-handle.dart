import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:notes/constants/utils.dart';

void httpErrorHandler(
    {required BuildContext context,
    required http.Response res,
    required VoidCallback onSuccess}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    default:
      print(jsonDecode(res.body)['msg']);
      String msg = jsonDecode(res.body)['msg'];
      showSnackBar(context, msg);
  }
}
