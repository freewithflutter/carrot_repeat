import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Exam extends StatefulWidget {
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  final _picker = ImagePicker();
  File _image;
  Future<void> selectedImage() async {
    var aim = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = aim;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload image'),
      ),
      body: _image == null
          ? Center(
              child: Text('hi'),
            )
          : Image.file(_image),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectedImage();
        },
      ),
    );
  }
}
