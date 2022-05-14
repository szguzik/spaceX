import 'package:app_happy_movies/lists.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InterestingSpace());
}

class InterestingSpace extends StatelessWidget {
  const InterestingSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interesujący Kosmos',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const ListPage(title: 'Interesujacy Kosmos'),
    );
  }
}
