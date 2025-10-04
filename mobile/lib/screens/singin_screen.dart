import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/data/notifiers.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/widgets/auth/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both username and password';
      });
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final data = await login(
        _usernameController.text,
        _passwordController.text,
      );
      setState(() {
        isLoading = false;
        errorMessage = null;
      });
      usernameNotifier.value = _usernameController.text;
      context.go('/');
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Login failed. Please check your credentials.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 300,
              width: 300,
            ),
            const Center(child: Text(
              'LOGIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 24
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  authInput(controller: _usernameController, isPassword: false, labelText: 'Username', icon: Icon(Icons.person_2_outlined)),
                  const SizedBox(height: 10),
                  authInput(controller: _passwordController, isPassword: true, labelText: 'Password', icon: Icon(Icons.vpn_key_outlined)),
                  const SizedBox(height: 20),
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
