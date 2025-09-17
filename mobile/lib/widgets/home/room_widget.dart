import 'package:flutter/material.dart';
import 'package:mobile/data/model/forum_data.dart';
import 'package:mobile/screens/forum_detail_screen.dart';

InkWell forumCard({
  required Forum forum,
  required BuildContext context
}) {
  // return Card(
  //   child: ListTile(
  //     title: Text(title),
  //     subtitle: Text(description),
  //     onTap: () {},
  //   ),
  // );

  String description = forum.description.length > 30
    ? forum.description.substring(0, 30) + " ..."
    : forum.description;


  return InkWell(
    onTap: () {
      print('Tapping forum with id of ${forum.id} & title of ${forum.title}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForumDetail(forumId: forum.id)) 
      );
    },

    child: Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: Colors.black,
          width: 0.5
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            forum.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),  
          ),
          Text(
            "$description - @${forum.owner}",
          )
        ],
      ),
    ),
  );
}

