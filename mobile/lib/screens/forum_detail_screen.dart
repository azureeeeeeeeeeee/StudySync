import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/widgets/forum_detail/pdf_card.dart';

class ForumDetail extends StatefulWidget {
  final int forumId;
  const ForumDetail({super.key, required this.forumId});

  @override
  State<ForumDetail> createState() => _ForumDetailState();
}

class _ForumDetailState extends State<ForumDetail> {
  Forum? forum;
  File? selectedFile;
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

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          Future<void> _pickFile() async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );

            if (result != null) {
              setStateDialog(() { // Use the setStateDialog function
                selectedFile = File(result.files.single.path!);
              });
            }
          }

          Future<void> _addFile() async {
            try {
              await Forum.addResource(
                titleController.text,
                selectedFile!,
                widget.forumId,
              );
              Navigator.pop(context);
              final updatedForum = await Forum.getForumById(widget.forumId);
              setState(() {
                forum = updatedForum;
                selectedFile = null;
              });
              forum = await Forum.getForumById(widget.forumId);
            } catch (e) {
              print('==== ERROR ====');
              print('Error : $e');
            }
          }

          return AlertDialog(
            title: Text('Tambah Kelompok Belajar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Judul'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: const Text("Pilih PDF"),
                  ),
                  SizedBox(height: 20),
                  if (selectedFile != null)
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        selectedFile!.path.split(Platform.pathSeparator).last,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    const Text(
                      "Belum ada file dipilih",
                      style: TextStyle(color: Colors.grey),
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
                  return pdfCard(
                    file: file, 
                    context: context, 
                    forum: forum!,
                    onDeleted: () async {
                      final updatedForum = await Forum.getForumById(widget.forumId);
                      setState(() {
                        forum = updatedForum;
                      });
                    }
                  );
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