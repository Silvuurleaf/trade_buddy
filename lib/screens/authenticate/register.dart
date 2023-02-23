import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trade_buddy/services/auth.dart';
import 'package:trade_buddy/widgets/shared/loading_widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  //handle errors from firebase
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
        title: const Text('Register to trade buddy'),
      ),

      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                //Email
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                //Password
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

                      dynamic result = await _auth.registerEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'supply a valid email and password';
                          loading = false;
                        });
                      }
                      else {

                      }
                      print('email: $email');
                      print('password: $password');
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 12,),

                //TODO add color and styling to error
                Text(error),

                const SizedBox(height: 12,),

                //Sign in page switch
                ElevatedButton(
                  onPressed: ()  {
                    widget.toggleView();
                  },
                  child: const Text('Sign In'),
                ),

              ],
            ),
          )

      ),
    );
  }
}
