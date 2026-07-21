import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/db/database.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/data/notifiers.dart';
import 'package:mobile/services/conn.dart';
import 'package:mobile/widgets/home/downloaded_widget.dart';
import 'package:mobile/widgets/home/room_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Forum> forums = [];
  final db = AppDatabase();

  @override
  void initState() {
    super.initState();
    fetchForums();

    NetworkUtils.onInternetStatusChange.listen((isOnline) {
      print("=== NETWORK STATUS ===");
      print('Network status: $isOnline');
      connectivityStatusNotifier.value = isOnline;
    });
  }

  Future<void> fetchForums() async {
    try {
      final allForums = await Forum.getAllforum();
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
        context.pop();
      } catch (e) {
        print('Error : $e');
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Kelompok Belajar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: _addForum,
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ValueListenableBuilder<bool>(
          valueListenable: isAuthenticatedNotifier,
          builder: (context, isAuthenticated, _) {
            return AppBar(
              backgroundColor: Colors.blueAccent,
              title: ValueListenableBuilder<String>(
                valueListenable: usernameNotifier,
                builder: (context, username, _) => Text(
                  isAuthenticated
                      ? 'Welcome, @$username'
                      : 'Welcome, Guest',
                ),
              ),
              actions: [
                if (!isAuthenticated)
                  TextButton.icon(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  TextButton.icon(
                    onPressed: () {
                      // simple logout action
                      isAuthenticatedNotifier.value = false;
                      usernameNotifier.value = "Anonymous User";
                      context.go('/login');
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            );
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ValueListenableBuilder<bool>(
          valueListenable: connectivityStatusNotifier,
          builder: (context, isOnline, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isOnline)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Colors.redAccent,
                    child: const Row(
                      children: [
                        Icon(Icons.wifi_off, color: Colors.white),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Anda tidak terhubung ke internet',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                const Text(
                  'Berikut ini adalah kelompok belajar yang tersedia',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: forums.length,
                    itemBuilder: (context, index) {
                      final forum = forums[index];
                      return AbsorbPointer(
                        absorbing: !isOnline,
                        child: Opacity(
                          opacity: isOnline ? 1 : 0.5,
                          child: forumCard(
                            forum: forum,
                            context: context,
                            db: db,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                  ),
                ),
                DownloadedWidget(db: db),
              ],
            );
          },
        ),
      ),

      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: connectivityStatusNotifier,
        builder: (context, isOnline, _) {
          return ValueListenableBuilder<bool>(
            valueListenable: isAuthenticatedNotifier,
            builder: (context, isAuthenticated, _) {
              
              if (!isOnline || !isAuthenticated) {
                return const SizedBox.shrink();
              }

              return FloatingActionButton(
                onPressed: _showAddRoomDialog,
                tooltip: 'Tambah Kelompok Belajar',
                child: const Icon(Icons.add),
              );
            },
          );
        },
      ),
    );
  }
}
