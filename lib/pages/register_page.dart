import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/componenets/my_button.dart';
import 'package:chatapp/componenets/my_text.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.message,
                size: 100,
              ),
              const SizedBox(height: 25),
              const Text(
                "Let's Create an account for you!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
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
              MyButton(onTap: signup, text: "Sign Up"),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a member?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
