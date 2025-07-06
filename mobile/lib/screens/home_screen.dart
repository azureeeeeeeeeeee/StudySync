import 'package:flutter/material.dart';
import 'package:mobile/data/notifiers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat datang, @${usernameNotifier.value}'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Text('Berikut ini adalah 3 kelompok belajar terbaru'),
              ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Kelompok Belajar 1'),
                      subtitle: Text('Deskripsi kelompok belajar 1'),
                      onTap: () {
                        // Aksi ketika kelompok belajar ditekan
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Kelompok Belajar 2'),
                      subtitle: Text('Deskripsi kelompok belajar 2'),
                      onTap: () {
                        // Aksi ketika kelompok belajar ditekan
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Kelompok Belajar 3'),
                      subtitle: Text('Deskripsi kelompok belajar 3'),
                      onTap: () {
                        // Aksi ketika kelompok belajar ditekan
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
