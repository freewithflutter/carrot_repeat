import 'package:carrot_repeat/examdetail.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Exam extends StatefulWidget {
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  String selectedPlace = '수유동';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: GestureDetector(
            onTap: () {},
            child: PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  selectedPlace = value;
                });
              },
              initialValue: '수유동',
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('수유동'),
                    value: '수유동',
                  ),
                  PopupMenuItem(
                    child: Text('미아동'),
                    value: '미아동',
                  ),
                  PopupMenuItem(
                    child: Text('길음동'),
                    value: '길음동',
                  ),
                ];
              },
              child: Row(
                children: [
                  Text(selectedPlace),
                  Icon(Icons.add),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Items')
                    .where('place', isEqualTo: selectedPlace)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              provider.selectedId =
                                  snapshot.data.docs[index].id;
                              Navigator.pushNamed(context, ExamDetail.id);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Hero(
                                    tag: snapshot.data.docs[index]
                                        .data()['image'],
                                    child: Image.network(
                                      snapshot.data.docs[index].data()['image'],
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Text(snapshot.data.docs[index]
                                      .data()['title']),
                                  Text(
                                      snapshot.data.docs[index].data()['place'])
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 2,
                            color: Colors.teal,
                          );
                        },
                        itemCount: snapshot.data.docs.length);
                  } else {
                    return Container();
                  }
                })),
      ),
    );
  }
}
// import 'package:carrot_repeat/examdetail.dart';
// import 'package:carrot_repeat/provider/item_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Exam extends StatefulWidget {
//   @override
//   _ExamState createState() => _ExamState();
// }
//
// class _ExamState extends State<Exam> {
//   String selectedPlace = '수유동';
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ItemProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: PopupMenuButton(
//           onSelected: (value) {
//             setState(() {
//               selectedPlace = value;
//               print(value);
//             });
//           },
//           itemBuilder: (BuildContext context) {
//             return [
//               PopupMenuItem(child: Text('수유동'), value: '수유동'),
//               PopupMenuItem(child: Text('미아동'), value: '미아동'),
//               PopupMenuItem(child: Text('길음동'), value: '길음동'),
//             ];
//           },
//           child: Row(
//             children: [
//               Text(selectedPlace),
//               Icon(Icons.add),
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//           child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('Items')
//                   .where('place', isEqualTo: selectedPlace)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 return ListView.separated(
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         provider.selectedId = snapshot.data.docs[index].id;
//                         // Navigator.pushNamed(context, ExamDetail.id);
//                       },
//                       child: Column(
//                         children: [
//                           Image.network(
//                             snapshot.data.docs[index].data()['image'],
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.fill,
//                           ),
//                           Text(snapshot.data.docs[index].data()['title']),
//                           Text(snapshot.data.docs[index].data()['place']),
//                           Text(snapshot.data.docs[index].data()['place']),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: snapshot.data.docs.length,
//                   separatorBuilder: (BuildContext context, int index) {
//                     return Container(
//                       height: 1,
//                       color: Colors.amber,
//                     );
//                   },
//                 );
//               })),
//     );
//   }
// }
