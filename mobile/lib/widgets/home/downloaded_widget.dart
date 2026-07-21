import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/db/database.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:path/path.dart' as p;

class DownloadedWidget extends StatelessWidget {
  final AppDatabase db;
  const DownloadedWidget({super.key, required this.db});

  Future<void> _deleteDownloadedItem(BuildContext context, DownloadedItem item) async {
    final file = File(item.path);
    bool deletedFromStorage = false;

    if (await file.exists()) {
      try {
        await file.delete();
        deletedFromStorage = true;
      } catch (e) {
        MotionToast.error(
          title: const Text("File Deletion Failed"),
          description: Text("Could not delete file: $e"),
        ).show(context);
      }
    }

    await (db.delete(db.downloadedItems)..where((tbl) => tbl.id.equals(item.id))).go();

    MotionToast.success(
      title: const Text("Deleted Successfully"),
      description: Text(
        deletedFromStorage
            ? '"${item.title}" was deleted.'
            : '"${item.title}" removed from list (file missing).',
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DownloadedItem>>(
      stream: db.select(db.downloadedItems).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final downloads = snapshot.data!;
        if (downloads.isEmpty) {
          return const Text("No downloaded files yet.");
        }

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
                    // GoRouter navigation works as usual
                    context.push('/read/pdf/offline', extra: file);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Delete File"),
                          content: Text('Are you sure you want to delete "${file.title}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await _deleteDownloadedItem(context, file);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
