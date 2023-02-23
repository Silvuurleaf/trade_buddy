import 'package:flutter/material.dart';

import '../models/Post.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text(posts[index].title),
                        Text(posts[index].author),
                        Text(posts[index].content),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
}