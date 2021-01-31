import 'package:carrot_repeat/components/temparature.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/homescreen.dart';
import 'package:carrot_repeat/util/default.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../anyscreen.dart';

class ItemDetail extends StatefulWidget {
  static final String id = 'itemdetail';

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance.collection('Items');
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map likedNow;
  bool _isLiked = false;
  bool _selectedHeart;
  Map<String, dynamic> data;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   await _firestore.collection('user').doc(_auth.currentUser.uid).set({
    //     "likes": [],
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    // _isLiked = provider.likedAbout;
    final String currentUser = user.uid;
    final fire = FirebaseFirestore.instance;
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Items')
                    .doc(provider.selectedId)
                    .get()
                    .then((DocumentSnapshot ds) {
                  _isLiked = ds.data()['likedNow'] == true;
                });
                print(_isLiked);
              }),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          // height: MediaQuery.of(context).size.height * 0.562,
        ],
      ),
      bottomNavigationBar: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Items')
              .doc(provider.selectedId)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              alignment: Alignment.center,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Color(0xFFF0F0F0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      StreamBuilder(
                          stream: _firestore
                              .collection('user')
                              .doc(_auth.currentUser.uid)
                              .snapshots(),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.hasError) {
                              return Text('Error');
                            }
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return IconButton(
                              onPressed: () async {
                                if (userSnapshot.data
                                    .data()['likes']
                                    .contains(provider.selectedId)) {
                                  await _firestore
                                      .collection('user')
                                      .doc(_auth.currentUser.uid)
                                      .update({
                                    "likes": FieldValue.arrayRemove(
                                        [provider.selectedId])
                                  });
                                  await _firestore
                                      .collection('Items')
                                      .doc(provider.selectedId)
                                      .update({
                                    'boolinga':
                                        FieldValue.arrayRemove([user.uid])
                                  });
                                  // await ds.reference
                                  //     .update({
                                  //   'boolinga': FieldValue
                                  //       .arrayRemove(
                                  //       [user.uid])
                                  // });
                                } else {
                                  await _firestore
                                      .collection('user')
                                      .doc(_auth.currentUser.uid)
                                      .update({
                                    "likes": FieldValue.arrayUnion(
                                        [provider.selectedId])
                                  });
                                  await _firestore
                                      .collection('Items')
                                      .doc(provider.selectedId)
                                      .update({
                                    'boolinga':
                                        FieldValue.arrayUnion([user.uid])
                                  });
                                }
                              },
                              icon: Icon(
                                  userSnapshot.data
                                          .data()['likes']
                                          .contains(provider.selectedId)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 26,
                                  color: kMainColor),
                            );
                          }),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        color: Colors.grey.shade300,
                        height: double.infinity,
                        width: 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data.data()['price']}원',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '가격제안불가',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: 138,
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _isLiked = (likedNow[currentUser] == true);
                        print(_isLiked);
                        // _store.doc(provider.selectedId).get({
                        // });
                      },
                      child: Center(
                        child: Text(
                          ' 거래하채팅으로기',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Items')
                .doc(provider.selectedId)
                .snapshots(),
            builder: (context, snapshot) {
              return Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.562,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Image.network(
                              snapshot.data.data()['image'],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        itemCount: 6,
                        viewportFraction: 1,
                        scale: 1,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              activeColor: kMainColor),
                        ),
                      ),
                    ),
                    //TODO section 2 seller profile
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFF0F0F0),
                        ),
                      )),
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 18, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 21,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data.data()['sellerId'] ??
                                        user.displayName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    snapshot.data.data()['place'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ManorTemperature(
                              manorTemp:
                                  snapshot.data.data()['temperature'] ?? 32),
                        ],
                      ),
                    ),
                    //TODO Section3 about item (상품설명)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.data()['title'] ?? '제목이 없습니',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '전자제품  3분전',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 12),
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data.data()['aboutItem'],
                              style: TextStyle(fontSize: 16, height: 1.25),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //TODO section 4 extra information grid part
                    Container(
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 18, bottom: 10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 68,
                              width: double.infinity,
                              child: Text(
                                '이 게시글 신고하기',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                bottom: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                              )),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
