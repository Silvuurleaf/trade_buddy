import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class DatabaseService {
  //collection reference

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

  Future updateUserData(String username) async{
    return await userCollection.doc(uid).set({
      'name':username,
    });
  }

  Future updatePostData(String username, String uid, String title,
      String content, List<String> tags, File images) async {

    //TODO how to save images to firestore

    return await userCollection.doc(uid).set({
      'Username':username,
      'userId': uid,
      'title': title,
      'content':content,
      'tags': tags,
      'images': images,
    });

  }

  //get posts stream

}