import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamDetail extends StatelessWidget {
  static String id = 'examDetail';
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Items')
            .doc(provider.selectedId)
            .snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Hero(
                  tag: Image.network(snapshot.data.data()['image']),
                  child: Image.network(snapshot.data.data()['image']))
            ],
          );
        });
  }
}

// import 'package:carrot_repeat/provider/item_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ExamDetail extends StatelessWidget {
//   static final String id = 'examDetail';
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ItemProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('detail exam'),
//       ),
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('Items')
//               .doc(provider.selectedId)
//               .snapshots(),
//           builder: (context, snapshot) {
//             return Container(
//                 // child: Image.network(snapshot.data.data()['image']),
//                 );
//           }),
//     );
//   }
// }
