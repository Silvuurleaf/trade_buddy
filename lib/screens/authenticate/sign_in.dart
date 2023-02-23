import 'package:flutter/material.dart';
import 'package:trade_buddy/services/auth.dart';
import 'package:trade_buddy/widgets/shared/loading_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  String error = '';

  final _formKey = GlobalKey<FormState>();

  //loading true -> show loading widget
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading_widget() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Sign in to trade buddy'),

      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Enter password thats 6 char long' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){

                    setState(() {
                      loading = true;
                    });

                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password
                    );

                    if(result == null){
                      setState(() {
                        error = 'Bad Credentials';
                        loading = false;
                      });
                    }
                  }
                },
                child: const Text('Sign In'),
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()  {
                  widget.toggleView();
                },
                child: const Text('Register'),
              ),

            ],
          ),
        )

      ),
    );
  }
}
