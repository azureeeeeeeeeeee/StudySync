import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/db/database.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:mobile/data/notifiers.dart';
import 'package:mobile/screens/pdf_viewer_screen.dart';
import 'package:motion_toast/motion_toast.dart';

InkWell pdfCard({
  required ForumFile file,
  required Forum forum,
  required BuildContext context,
  required VoidCallback onDeleted,
  required AppDatabase db
}) {
  return InkWell(
    onTap: () {
      debugPrint("Going to ${file.url}");
      // Navigator.push(
      //   context, 
      //   MaterialPageRoute(builder: (context) => PdfViewerScreen(file: file))
      // );
      context.push('/read/pdf', extra: file);
    },
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),
          SizedBox(width: 30,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                file.title,
                style: TextStyle(
                  fontStyle: FontStyle.italic
                ),
              )
            ],
          ),
          Spacer(),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.blue),
            tooltip: 'Download This File',
            onPressed: () async {
              try {
                final filePath = await Forum.downloadFile(file.url, file.title, db);
                MotionToast.success(
                  description: const Text("Downloading "),
                  toastAlignment: Alignment.topLeft,
                  toastDuration: Duration(seconds: 5),
                ).show(context);
              } catch (e) {
                MotionToast.error(
                  description: Text('Download failed: $e'),
                  toastAlignment: Alignment.topLeft,
                  toastDuration: Duration(seconds: 5),
                  ).show(context);
              }
            },
          ),

          usernameNotifier.value == forum.owner ? 
          SizedBox(
            width: 25,
            height: 25,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              onPressed: () async {
                await Forum.deleteResource(forum.id, file.id);
                onDeleted();
              }, 
              child: Text('X'),
            ),
          ) : SizedBox()
        ],
      )
    ),
  );
}