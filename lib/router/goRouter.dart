
import 'package:go_router/go_router.dart';
import 'package:trade_buddy/screens/wrapper.dart';

final _router = GoRouter(
    initialLocation: '/',
    routes:[
      GoRoute(
        path:'/',
        builder: (context, state) => const Wrapper(),)
    ]
);