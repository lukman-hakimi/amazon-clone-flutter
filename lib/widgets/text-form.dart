import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool obscureText;

  const TextForm(
      {required this.controller, required this.hintText, this.maxLines = 1, this.autocorrect = true, this.enableSuggestions = true, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      obscureText: obscureText,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
    );
  }
}
