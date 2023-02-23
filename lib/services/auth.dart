import 'package:firebase_auth/firebase_auth.dart';
import 'package:trade_buddy/models/trade_buddy_user.dart';
import 'package:trade_buddy/services/database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user objecty based on firebase user
  trade_buddy_user? _userFromFirebaseUser(User? user){
      return user != null ? trade_buddy_user(uid: user.uid) : null;
  }

  //auth change user stream
  //gets info everythime user logs in or out and map it tour class variable
  Stream<trade_buddy_user?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  //sign guest
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in w/ email and password

  Future<trade_buddy_user?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebaseUser(user.user);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return null;
    }
  }

  //register email and password

  Future registerEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new doc for user with uid
      await DatabaseService(uid: user!.uid).updateUserData('leaf');

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}