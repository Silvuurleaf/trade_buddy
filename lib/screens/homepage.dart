import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_buddy/services/auth.dart';

import '../widgets/postlist.dart';

class ForumApp extends StatefulWidget {
  @override
  _ForumAppState createState() => _ForumAppState();
}

class _ForumAppState extends State<ForumApp> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Buddy'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.person),
              label: const Text('Log Out'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the forum!',
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to create post screen
                context.push('/createPost');
              },
              child: const Text('Create a new post'),
            ),

            //PostList(),

          ],
        ),
      ),
    );
  }
}

