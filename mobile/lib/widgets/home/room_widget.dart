// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'dart:math';
// import 'package:mobile/data/model/forum_data.dart';

// Color getRandomColor() {
//   const colors = [
//     Colors.deepPurple,
//     Colors.blueAccent,
//     Colors.orangeAccent,
//     Colors.green,
//     Colors.teal,
//     Colors.pinkAccent,
//     Colors.redAccent,
//   ];
//   return colors[Random().nextInt(colors.length)];
// }

// InkWell forumCard({
//   required Forum forum,
//   required BuildContext context
// }) {
//   // return Card(
//   //   child: ListTile(
//   //     title: Text(title),
//   //     subtitle: Text(description),
//   //     onTap: () {},
//   //   ),
//   // );

//   String description = forum.description.length > 30
//     ? forum.description.substring(0, 30) + " ..."
//     : forum.description;

//     final color = getRandomColor();


//   return InkWell(
//     onTap: () {
//       context.go("/forum/${forum.id}");
//     },

//     child: Container(
//       padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
//       decoration: BoxDecoration(
//         border: BoxBorder.all(
//           color: Colors.black,
//           width: 0.5
//         ),
//         borderRadius: BorderRadius.circular(5)
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             forum.title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold
//             ),  
//           ),
//           Text(
//             "$description - @${forum.owner}",
//           )
//         ],
//       ),
//     ),
//   );
// }


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/data/model/forum_data.dart';

Color getRandomColor() {
  const colors = [
    Colors.deepPurple,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.green,
    Colors.teal,
    Colors.pinkAccent,
    Colors.redAccent,
  ];
  return colors[Random().nextInt(colors.length)];
}

InkWell forumCard({
  required Forum forum,
  required BuildContext context,
}) {
  String description = forum.description.length > 60
      ? forum.description.substring(0, 60) + " ..."
      : forum.description;

  final color = getRandomColor();

  return InkWell(
    onTap: () {
      context.push("/forum/${forum.id}");
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 90,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forum.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${forum.owner}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
