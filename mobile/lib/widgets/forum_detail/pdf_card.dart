import 'package:flutter/material.dart';
import 'package:mobile/data/class/forum_file_data.dart';
import 'package:mobile/screens/pdf_viewer_screen.dart';

InkWell pdfCard({
  required ForumFile file,
  required BuildContext context  
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
        ],
      )
    ),
  );
}