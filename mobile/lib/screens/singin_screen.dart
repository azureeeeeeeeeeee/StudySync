// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mobile/data/notifiers.dart';
// import 'package:mobile/services/auth.dart';
// import 'package:mobile/widgets/auth/input.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:motion_toast/resources/arrays.dart';


// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool isLoading = false;
//   String? errorMessage;

//   Future<void> _login() async {
//     if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
//       setState(() {
//         errorMessage = 'Please enter both username and password';
//       });
//       return;
//     }
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final data = await login(
//         _usernameController.text,
//         _passwordController.text,
//       );
//       setState(() {
//         isLoading = false;
//         errorMessage = null;
//       });
//       usernameNotifier.value = _usernameController.text;
//       isAuthenticatedNotifier.value = true;

//       MotionToast.success(
//         description: const Text("Login Successful"),
//         toastAlignment: Alignment.topLeft,
//         toastDuration: Duration(seconds: 5),
//       ).show(context);
      
//       context.go('/');
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       MotionToast.error(
//         description: const Text("Login failed. Please check your credentials"),
//         toastAlignment: Alignment.topLeft,
//         toastDuration: Duration(seconds: 5),
//       ).show(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 50),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/logo/logo.png',
//               height: 300,
//               width: 300,
//             ),
//             const Center(child: Text(
//               'Login to your account',
//               style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.italic,
//                 fontSize: 20
//               ),
//             )),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 children: [
//                   authInput(controller: _usernameController, isPassword: false, labelText: 'Username', icon: Icon(Icons.person_2_outlined)),
//                   const SizedBox(height: 10),
//                   authInput(controller: _passwordController, isPassword: true, labelText: 'Password', icon: Icon(Icons.vpn_key_outlined)),
//                   const SizedBox(height: 20),
//                   isLoading
//                       ? CircularProgressIndicator()
//                       : ElevatedButton(
//                         onPressed: _login,
//                         child: const Text('Login'),
//                       ),
//                   const SizedBox(height: 25),
//                   TextButton(
//                     onPressed: () {
//                       context.go('/register');
//                     },
//                     child: const Text('Don\'t have an account? Sign Up'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/notifiers.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/widgets/auth/input.dart';
import 'package:motion_toast/motion_toast.dart';

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
      errorMessage = null;
    });

    try {
      final data = await login(
        _usernameController.text,
        _passwordController.text,
      );

      usernameNotifier.value = _usernameController.text;
      isAuthenticatedNotifier.value = true;

      MotionToast.success(
        description: const Text("Login Successful"),
        toastAlignment: Alignment.topLeft,
        toastDuration: const Duration(seconds: 5),
      ).show(context);

      context.go('/');
    } catch (e) {
      MotionToast.error(
        description: const Text(
          "Login failed. Please check your credentials",
        ),
        toastAlignment: Alignment.topLeft,
        toastDuration: const Duration(seconds: 5),
      ).show(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 10),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),

              // Show error message if exists
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    authInput(
                      controller: _usernameController,
                      isPassword: false,
                      labelText: 'Username',
                      icon: const Icon(Icons.person_2_outlined),
                    ),
                    const SizedBox(height: 10),
                    authInput(
                      controller: _passwordController,
                      isPassword: true,
                      labelText: 'Password',
                      icon: const Icon(Icons.vpn_key_outlined),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text('Login'),
                          ),
                    const SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      child: const Text("Don't have an account? Sign Up"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
