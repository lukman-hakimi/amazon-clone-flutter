import 'package:flutter/material.dart';
import 'package:notes/providers/user.dart';
import 'package:notes/screens/admin.dart';
import 'package:notes/screens/login.dart';
import 'package:notes/services/auth-services.dart';
import 'package:notes/widgets/bottombar.dart';
import 'package:provider/provider.dart';
import './screens/screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthServices auth = AuthServices();

  @override
  void initState() {
    auth.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffe9e9f3),
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? LoginScreen()
          : Provider.of<UserProvider>(context).user.type == "user"
              ? BottomBar()
              : BottomBar(),
    );
  }
}
