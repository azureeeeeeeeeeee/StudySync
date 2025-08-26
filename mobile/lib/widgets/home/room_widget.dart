import 'package:flutter/material.dart';
import 'package:mobile/data/class/forum_data.dart';

InkWell forumCard({
  required Forum forum
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

