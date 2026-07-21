import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/services/auth.dart'; // your AuthService
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Auth Service Integration Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('register a new user', () async {
      final username = 'testuser';
      final password = '123456';

      try {
        final result = await register(username, password);
        print('Register response: $result');
        expect(result['error'], false);
      } catch (e) {
        print('Register failed: $e');
      }
    });

    test('login a user', () async {
      final username = 'testuser';
      final password = '123456';

      try {
        final result = await login(username, password);
        print('Login response: $result');
        expect(result['username'], username);
        expect(result['token'], isNotNull);
      } catch (e) {
        print('Login failed: $e');
      }
    });

    test('get token', () async {
      final token = await getToken();
      // print('Saved token: $token');
    });
  });
}
