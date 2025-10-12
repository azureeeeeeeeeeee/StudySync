import 'package:go_router/go_router.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:mobile/screens/forum_detail_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/pdf_viewer_screen.dart';
import 'package:mobile/screens/signup_screen.dart';
import 'package:mobile/screens/singin_screen.dart';

final GoRouter routes = GoRouter(
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
        return PdfViewerScreen(file: file);
      } 
    ),
  ],
);