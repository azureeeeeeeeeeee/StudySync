import 'package:flutter/material.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/data/notifiers.dart';
import 'package:mobile/widgets/home/room_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}



class HomePageState extends State<HomePage> {
  List<Forum> forums = [];

  @override
  void initState() {
    super.initState();

    fetchForums();
  }

  Future<void> fetchForums() async {
    try {
      final allForums = await Forum.getAllforum();
      print("==== Forums ====");
      print(forums);
      setState(() {
        forums = allForums;
      });
    } catch (e) {
      print('Error fetching forums: $e');
    }
  }


  void _showAddRoomDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    Future<void> _addForum() async {
      Map<String, String> data = {
        'title': titleController.text,
        'description': descriptionController.text
      };

      try {
        await Forum.addForum(data);
        await fetchForums();
        Navigator.pop(context);
      } catch (e) {
        print('==== ERROR ====');
        print('Error : $e');
      }
    }

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
              onPressed: _addForum,
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
              child: ListView.separated(
                itemCount: forums.length,
                itemBuilder: (context, index) {
                  final forum = forums[index];
                  return forumCard(forum: forum, context: context);
                },                
                separatorBuilder: (context, index) => SizedBox(height: 15,),
                scrollDirection: Axis.vertical,
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
