import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/db/database.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfOfflineViewerScreen extends StatelessWidget {
  final DownloadedItem item;
  const PdfOfflineViewerScreen({super.key, required this.item});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_outlined),
          onTap: () => context.pop(),
        ),
      ),
      body: SfPdfViewer.file(File(item.path)),
    );
  }
}