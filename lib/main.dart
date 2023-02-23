import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trade_buddy/providers/postProvider.dart';
import 'package:trade_buddy/screens/createPostForm.dart';
import 'package:trade_buddy/screens/homepage.dart';
import 'package:trade_buddy/screens/wrapper.dart';

import 'models/trade_buddy_user.dart';
import 'services/auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<postProvider>(create:
              (context) => postProvider()),
          StreamProvider<trade_buddy_user?>.
            value(value: AuthService().user, initialData: null), //StreamProvider

        ],
        child: const MyApp(),
      )
  );
}

final _router = GoRouter(
    initialLocation: '/',
    routes:[
      GoRoute(
        path:'/',
        builder: (context, state) => const Wrapper(),
      ),

      GoRoute(
        path: '/createPost',
        builder:(context, state) => createPostForm(),
      )
    ]
);




class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'task app',
      routerConfig: _router,
    );
  }
}


