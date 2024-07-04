import 'package:allevent/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allevent/componenets/my_button.dart';
import 'package:allevent/componenets/my_text.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signin() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: emailController,
          hintText: 'Email',
          obsecureText: false,
        ),
        const SizedBox(height: 10),
        MyTextField(
          controller: passwordController,
          hintText: 'Password',
          obsecureText: true,
        ),
        const SizedBox(height: 25),
        MyButton(
          onTap: signin,
          text: "Sign In",
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
