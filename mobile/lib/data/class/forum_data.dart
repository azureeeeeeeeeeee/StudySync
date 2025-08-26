import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/services/auth.dart';
import 'package:http/http.dart' as http;


class Forum {
  final int id;
  final String title;
  final String description;
  final String owner;

  Forum({
    required this.id,
    required this.title,
    required this.description,
    required this.owner
  });



  // Json to object
  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      owner: json['owner']
    );
  }



  // Create Forum
  static Future<Map<String, dynamic>> addForum(Map<String, String> data) async {
    final uri = Uri.parse("$BASE_URL/api/forum");
    final token = await getToken();

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"},
      body: jsonEncode(data)
    );

    if (response.statusCode != 200) {
      String errorMessage = 'Terjadi Kesalahan';

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



  // Get all forums
  static Future<List<Forum>> getAllforum() async {
    final uri = Uri.parse("$BASE_URL/api/forum");
    
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode != 200) {
      String errorMessage = 'Terjadi kesalahan';

      try {
        final resError = jsonDecode(response.body);
        errorMessage = resError['message'] ?? errorMessage;
      } catch (e) {
        errorMessage = 'Error : ${response.reasonPhrase}';
      }

      throw Exception(errorMessage);
    }

    final resData = jsonDecode(response.body);

    final List<dynamic> forumsJson = resData['data'] ?? [];

    return forumsJson.map((json) => Forum.fromJson(json)).toList();
  }



  // Get one forum
  static Future<Forum> getForumById(int id) async {
    final uri = Uri.parse("$BASE_URL/api/forum/$id");

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode != 200) {
      String errorMessage = 'Terjadi kesalahan';

      try {
        final resError = jsonDecode(response.body);
        errorMessage = resError['message'] ?? errorMessage;
      } catch (e) {
        errorMessage = 'Error : ${response.reasonPhrase}';
      }

      throw Exception(errorMessage);
    }

    final resData = jsonDecode(response.body);

    final dynamic forumJson = resData['data'] ?? {};

    return Forum.fromJson(forumJson);
  }


}