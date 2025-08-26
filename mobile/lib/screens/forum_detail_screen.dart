import 'package:flutter/material.dart';
import 'package:mobile/data/class/forum_data.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetched ${widget.forumId}"),
      ),
    );
  }
}