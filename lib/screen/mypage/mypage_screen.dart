import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/util/default.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//TODO Favorite item list up
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  String itemId;
  void initState() {
    FirebaseFirestore.instance.collection('user').doc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ItemProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('관심목록'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: kMainColor,
                    tabs: [
                      Tab(
                        child: Text('중고거래'),
                      ),
                      Tab(
                        child: Text('동넵홍보'),
                      ),
                      Tab(
                        child: Text('동네생활'),
                      ),
                      Tab(
                        child: Text('동네업체'),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7276,
                    child: TabBarView(children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .snapshots(),
                          builder: (context, userSnapshot) {
                            return Container(
                              child: SizedBox(
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Items')
                                        .where('boolinga',
                                            arrayContains: _user.uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // provider.selectedId =
                                          //     snapshot.data.docs[index].id;
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    snapshot.data.docs[index]
                                                        .data()['image'],
                                                    width: 110,
                                                    height: 110,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 110,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * 0.5,
                                                              child: Container(
                                                                child: Text(
                                                                  snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .data()[
                                                                      'title'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            StreamBuilder(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'user')
                                                                    .doc(_user
                                                                        .uid)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    userSnapshot) {
                                                                  DocumentSnapshot
                                                                      ds =
                                                                      snapshot
                                                                          .data
                                                                          .docs[index];
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        'Check Error');
                                                                  }
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return CircularProgressIndicator();
                                                                  }
                                                                  return GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      provider.selectedId = snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .id;
                                                                      if (snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .data()[
                                                                              'boolinga']
                                                                          .contains(
                                                                              _user.uid)) {
                                                                        await _firestore
                                                                            .collection('user')
                                                                            .doc(_user.uid)
                                                                            .update({
                                                                          "likes":
                                                                              FieldValue.arrayRemove([
                                                                            provider.selectedId
                                                                          ])
                                                                        });
                                                                        await ds
                                                                            .reference
                                                                            .update({
                                                                          'boolinga':
                                                                              FieldValue.arrayRemove([
                                                                            _user.uid
                                                                          ])
                                                                        });
                                                                        await ds
                                                                            .reference
                                                                            .update({
                                                                          'likes':
                                                                              FieldValue.increment(-1)
                                                                        });
                                                                      } else if (!snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .data()[
                                                                              'boolinga']
                                                                          .contains(
                                                                              _user.uid)) {
                                                                        await _firestore
                                                                            .collection('user')
                                                                            .doc(_user.uid)
                                                                            .update({
                                                                          "likes":
                                                                              FieldValue.arrayUnion([
                                                                            provider.selectedId
                                                                          ])
                                                                        });
                                                                        await ds
                                                                            .reference
                                                                            .update({
                                                                          'boolinga':
                                                                              FieldValue.arrayUnion([
                                                                            _user.uid
                                                                          ])
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                        snapshot.data.docs[index].data()['boolinga'].contains(_user.uid)
                                                                            ? Icons
                                                                                .favorite
                                                                            : Icons
                                                                                .favorite_border,
                                                                        size:
                                                                            24,
                                                                        color:
                                                                            kMainColor),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .data.docs[index]
                                                              .data()['place'],
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  kLightGrayBlueColor),
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text(
                                                          '${NumberFormat('###,###,### 원').format(int.parse(snapshot.data?.docs[index].data()['price'] ?? ''))}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ),
                            );
                          }),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                      Tab(icon: Icon(Icons.directions_bike))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
