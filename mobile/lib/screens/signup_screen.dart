import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';
import 'package:mobile/screens/singin_screen.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/widgets/auth/input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  Future<void> _signup() async {
    Map<String, dynamic> data = {
      'username': _emailController.text,
      'password': _passwordController.text,
      'confirm_password': _confirmPasswordController.text,
    };

    setState(() {
      isLoading = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
        isLoading = false;
      });
      return;
    }

    try {
      await register(_emailController.text, _passwordController.text);
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Signup failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.tealAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Create a new account', style: TextStyle(fontSize: 20)),
          ),
          if (errorMessage != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                authInput(controller: _emailController, isPassword: false, labelText: "Username"),
                SizedBox(height: 10),
                authInput(controller: _passwordController, isPassword: true, labelText: "Password"),
                SizedBox(height: 10),
                authInput(controller: _confirmPasswordController, isPassword: true, labelText: "Confirm Password"),
                SizedBox(height: 20),

                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: _signup,
                      child: const Text('Sign Up'),
                    ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
