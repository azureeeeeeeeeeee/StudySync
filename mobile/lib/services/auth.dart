import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Auth Service - Register
Future<Map<String, dynamic>> register(username, password) async {
  Map<String, String> data = {'username': username, 'password': password};

  final uri = Uri.parse('$BASE_URL/auth/register');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

 if (response.statusCode != 201) {
    final body = response.body;
    throw Exception('Terjadi kesalahan');
  }

  final resData = jsonDecode(response.body);

  return {'message': resData['message'], 'error': false};
}





// Auth Service - Login
Future<Map<String, dynamic>> login(username, password) async {
  Map<String, String> data = {'username': username, 'password': password};

  final uri = Uri.parse('$BASE_URL/auth/login');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Terjadi kesalahan');
  }

  final resData = jsonDecode(response.body);

  Map<String, dynamic> returnData = {
    'username': username,
    'token': resData['data'],
    'message': resData['message'],
  };

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', resData['data']);

  return returnData;
}

// Auth Service - Get Token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
