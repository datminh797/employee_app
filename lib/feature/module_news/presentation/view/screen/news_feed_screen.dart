import 'package:flutter/material.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Container(
            height: 250,
            color: Colors.white,
            child: Text('News Feed'),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: 10,
      ),
    );
  }
}
