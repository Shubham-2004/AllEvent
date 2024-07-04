import 'package:allevent/presentation/search/Screen/login_screen.dart';
import 'package:allevent/presentation/search/Screen/register_screen.dart';
import 'package:flutter/material.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  bool showLoginPage = true;
  void togglepage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglepage);
    } else {
      return RegisterPage(onTap: togglepage);
    }
  }
}
