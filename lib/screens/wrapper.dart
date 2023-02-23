import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_buddy/screens/authenticate/authenticate.dart';

import '../models/trade_buddy_user.dart';
import 'homepage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<trade_buddy_user?>(context);

    print(user);

    if(user == null){
      //return authentication page or home page based off sign in
      return Authenticate();
    }
    else {
        return ForumApp();
    }
  }
}
