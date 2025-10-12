import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/db/database.dart';
import 'package:path/path.dart' as p;

class DownloadedWidget extends StatelessWidget {
  final AppDatabase db;
  const DownloadedWidget({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DownloadedItem>>(
      stream: db.select(db.downloadedItems).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final downloads = snapshot.data!;
        if (downloads.isEmpty) return const Text("No downloaded files yet.");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📂 Downloaded Files",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: downloads.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final file = downloads[index];
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(file.title),
                  subtitle: Text(p.basename(file.path)),
                  onTap: () {
                    context.push(
                      '/read/pdf/offline',
                      extra: file,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
