import "package:flutter/material.dart";
import 'package:notes/screens/login.dart';
import 'package:notes/services/auth-services.dart';
import 'package:http/http.dart' as http;
import 'package:notes/widgets/text-form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _register() async {
    var data = await AuthServices().signUp(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextForm(
                    controller: _name,
                    hintText: "Name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextForm(
                      controller: _email,
                      hintText: 'Email',
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: false),
                  SizedBox(
                    height: 10,
                  ),
                  TextForm(
                      controller: _password,
                      hintText: 'Password',
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: false),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          _register();
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                        }
                        ;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: Text(
                          "Regsiter",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                  "Email is ${_email.text} and password is ${_password.text}"),
            ),
          ],
        ),
      ),
    );
  }
}
