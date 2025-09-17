import 'package:flutter/material.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfViewerScreen extends StatelessWidget {
  final ForumFile file;
  const PdfViewerScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.title),
      ),
      body: SfPdfViewer.network(file.url),
    );
  }
}