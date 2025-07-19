import 'package:flutter/material.dart';
import 'package:mobile/data/class.dart';
import 'package:mobile/data/notifiers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Room> rooms = [
    Room(
      id: 1,
      title: 'Folder Belajar 1',
      description: 'Deskripsi Folder belajar 1',
    ),
    Room(
      id: 2,
      title: 'Folder Belajar 2',
      description: 'Deskripsi Folder belajar 2',
    ),
    Room(
      id: 3,
      title: 'Folder Belajar 3',
      description: 'Deskripsi Folder belajar 3',
    ),
    Room(
      id: 4,
      title: 'Folder Belajar 4',
      description: 'Deskripsi Folder belajar 4',
    ),
    Room(
      id: 5,
      title: 'Folder Belajar 5',
      description: 'Deskripsi Folder belajar 5',
    ),
  ];

  void _showAddRoomDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Kelompok Belajar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rooms.add(
                    Room(
                      id: rooms.length + 1,
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat datang, @${usernameNotifier.value}'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berikut ini adalah kelompok belajar yang tersedia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Card(
                    child: ListTile(
                      title: Text(room.title),
                      subtitle: Text(room.description),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoomDialog,
        tooltip: 'Tambah Kelompok Belajar',
        child: Icon(Icons.add),
      ),
    );
  }
}
