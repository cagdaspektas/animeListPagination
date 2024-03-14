import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String score;
  const RatingWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        const Text(
          'Rating:',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            score,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
