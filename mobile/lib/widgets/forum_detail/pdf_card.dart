import 'package:flutter/material.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:mobile/screens/pdf_viewer_screen.dart';

InkWell pdfCard({
  required ForumFile file,
  required Forum forum,
  required BuildContext context,
  required VoidCallback onDeleted  
}) {
  return InkWell(
    onTap: () {
      print("Going to ${file.url}");
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => PdfViewerScreen(file: file))
      );
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
          )
        ],
      )
    ),
  );
}