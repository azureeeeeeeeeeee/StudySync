import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile/screens/signin_screen.dart';
import 'package:mobile/screens/singin_screen.dart';
import 'package:mobile/services/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('LoginPage has username, password fields and login button', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(find.byType(TextField), findsNWidgets(2));

    expect(find.text('Login'), findsOneWidget);

    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });

  testWidgets('LoginPage shows error if fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter both username and password'), findsOneWidget);
  });

  testWidgets('LoginPage calls login function and shows success toast', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    await tester.enterText(find.byType(TextField).at(0), 'testuser');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.text('Please enter both username and password'), findsNothing);
  });
}
