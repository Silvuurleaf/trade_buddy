import 'package:flutter/material.dart';
import 'package:trade_buddy/screens/authenticate/register.dart';
import 'package:trade_buddy/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn){
      return Container(
        child: SignIn(toggleView: toggleView),
      );
    }
    else {
      return Container(
        child: Register(toggleView: toggleView),
      );
    }


  }
}
