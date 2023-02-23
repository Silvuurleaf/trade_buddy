import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class createPostForm extends StatefulWidget {

  var postId;

  createPostForm({
    Key? key,
    this.postId,
  }) : super(key: key);


  @override
  State<createPostForm> createState() => _createPostForm();
}

//TODO need to add GPS pin and interactive map

class _createPostForm extends State<createPostForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  late File _image;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Post Creation'),
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(140),
              ],
              decoration: const InputDecoration(
                hintText:'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1000),
              ],
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Text(optional)',
              ),
              maxLines: 5,
              validator: (value) {
                //TODO make it okay to submit an empty post.
                if (value!.isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
              onSaved: (value) {
                _content = value!;
              },
            ),

            Center(
              child: Container(
                height: 300,
                width: 300,
                child: _image == null ?
                    const Text('No Image Selected')
                    : Image.asset(_image.path,)
              ),
            ),

            TextButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Select Image'),
              onPressed: getImage,
            ),

            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Do something with the data, e.g. create a new post
      print('Title: $_title\nContent: $_content');


      //Add post to the database

    }
  }

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });

      } else {
        print('No image selected.');
        return;
      }
    });
  }

}