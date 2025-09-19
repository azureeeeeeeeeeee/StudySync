import 'package:flutter/material.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/data/model/forum_file_data.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfViewerScreen extends StatelessWidget {
  final ForumFile file;
  const PdfViewerScreen({super.key, required this.file});

  void _showChatDialog(BuildContext context) {
    final questionController = TextEditingController();
    String? answer;
    bool isLoading = false;

   showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> _askQuestion() async {
              final question = questionController.text.trim();
              if (question.isEmpty) return;

              setState(() {
                isLoading = true;
                answer = null;
              });

              try {
                // print(file.url.replaceFirst("$BASE_URL/uploads/", ""));
                final result = await Forum.askAI(question, file.url.replaceFirst("$BASE_URL/uploads/", ""));
                setState(() {
                  answer = result;
                });
              } catch (e) {
                setState(() {
                  answer = "Error: $e";
                });
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            }

            return AlertDialog(
              title: Text("Ask AI - ${file.title}"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: questionController,
                    decoration: const InputDecoration(
                      labelText: "Your question",
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else if (answer != null)
                    Text(
                      "Answer: $answer",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
                ElevatedButton(
                  onPressed: _askQuestion,
                  child: const Text("Ask"),
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
        title: Text(file.title),
      ),
      body: SfPdfViewer.network(file.url),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showChatDialog(context),
        tooltip: "Ask AI",
        child: Icon(Icons.chat_sharp),
        
      ),
    );
  }
}