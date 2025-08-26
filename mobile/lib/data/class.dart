class Room {
  final int id;
  final String title;
  final String description;
  final String owner;

  Room({required this.id, required this.title, required this.description, required this.owner});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      owner: json['owner']
    );
  }
}
