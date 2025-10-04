import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:mobile/screens/forum_detail_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/pdf_viewer_screen.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/screens/singin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/forum/:id',
        builder: (context, state) {
          final forumId = int.parse(state.pathParameters['id']!);
          return ForumDetail(forumId: forumId);
        } 
      ),
      GoRoute(
        path: '/read/pdf',
        builder: (context, state) {
          final file = state.extra as ForumFile;
          // final forumId = int.parse(state.pathParameters['id']!);
          return PdfViewerScreen(file: file);
        } 
      ),
    ],
    // redirect: (context, state) {
      
    // },
  );

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //   ),
    //   home: const LoginPage(),
    // );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "StudySync",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      routerConfig: router,
    );
  }
}
