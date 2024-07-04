import 'package:allevent/services/auth/auth_gate.dart';
import 'package:allevent/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allevent/componenets/my_button.dart';
import 'package:allevent/componenets/my_text.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signup() async {
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.registerWithEmailAndPassword(
          emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful! Please login.")),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Authgate()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
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
        const SizedBox(height: 10),
        MyTextField(
          controller: confirmpasswordController,
          hintText: 'Confirm Password',
          obsecureText: true,
        ),
        const SizedBox(height: 25),
        MyButton(
          onTap: signup,
          text: "Sign Up",
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
