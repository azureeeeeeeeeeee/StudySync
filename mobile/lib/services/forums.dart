import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';
import 'package:mobile/services/auth.dart';


// Auth Service - Register
Future<Map<String, dynamic>> addForum(title, description) async {
  Map<String, String> data = {'title': title, 'description': description};

  final uri = Uri.parse('$BASE_URL/api/forum');
  final token = await getToken();

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    body: jsonEncode(data),
  );

 if (response.statusCode != 200) {
    String errorMessage = 'Terjadi kesalahan';

    try {
      final resError = jsonDecode(response.body);
      errorMessage = resError['message'] ?? errorMessage;
    } catch (e) {
      errorMessage = 'Error: ${response.reasonPhrase}';
    }

    throw Exception(errorMessage);
  }

  final resData = jsonDecode(response.body);

  return {'message': resData['message'], 'error': false};
}
