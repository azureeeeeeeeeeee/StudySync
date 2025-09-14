import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/class/forum_data.dart';
import 'package:mobile/widgets/forum_detail/pdf_card.dart';

class ForumDetail extends StatefulWidget {
  final int forumId;
  const ForumDetail({super.key, required this.forumId});

  @override
  State<ForumDetail> createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  Forum? forum;
  @override
  void initState() {
    super.initState();
    _loadForum();
  }

  Future<void> _loadForum() async {
    final fetchedForum = await Forum.getForumById(widget.forumId);
    setState(() {
      forum = fetchedForum;
    });
  }


  void _showAddFileDialog() {
    final titleController = TextEditingController();
    File? selectedFile;

    Future<void> _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
        });
      }
    }
    
    Future<void> _addFile() async {      
      try {
        await Forum.addResource(
          titleController.text,
          selectedFile!,
          widget.forumId
        );
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

              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: const Text("Pilih PDF"),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: _addFile,
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
        title: Text("Fetched ${widget.forumId}"),
      ),

      body: forum == null ? 
      const Center(child: CircularProgressIndicator()) : 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                forum!.title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              forum!.description),
            SizedBox(height: 10),
            Text("by @${forum!.owner}"),
            SizedBox(height: 40,),
            Text(
              'Materi Belajar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.separated(
                itemCount: forum!.files.length,
                itemBuilder: (context, index) {
                  final file = forum!.files[index];
                  return pdfCard(file: file, context: context);
                }, 
                separatorBuilder: (context, index) => SizedBox(height: 15),
                scrollDirection: Axis.vertical, 
              )
            )
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFileDialog,
        tooltip: 'Tambah Kelompok Belajar',
        child: Icon(Icons.add),
      )
    );
  }
}