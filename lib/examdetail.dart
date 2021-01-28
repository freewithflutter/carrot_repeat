import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamDetail extends StatefulWidget {
  @override
  _ExamDetailState createState() => _ExamDetailState();
}

final _fire = FirebaseFirestore.instance.collection('Items').snapshots();

List<bool> _likes = List.filled(3, true);

class _ExamDetailState extends State<ExamDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('example'),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                color: Colors.green,
                height: 100,
                width: 200,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('$index'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _likes[index] = !_likes[index];
                        });
                      },
                      icon: Icon(_likes[index]
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
