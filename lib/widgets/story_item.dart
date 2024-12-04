import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150', // URL avatar
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Your Story',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'LexendDeca', // Menggunakan font Lexend Deca
            ),
          ),
        ],
      ),
    );
  }
}