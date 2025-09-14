import 'package:mobile/constants.dart';

class ForumFile {
  final int id;
  final String title;
  final String url;

  ForumFile({
    required this.id,
    required this.title,
    required this.url,
  });

  factory ForumFile.fromJson(Map<String, dynamic> json) {
    return ForumFile(
      id: json['id'],
      title: json['title'],
      url: "${BASE_URL}${json['url']}",
    );
  }
}