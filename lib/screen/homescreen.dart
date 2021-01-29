import 'package:carrot_repeat/components/temparature.dart';
import 'package:carrot_repeat/provider/google_sign_in_provider.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/additem/additem_screen.dart';
import 'package:carrot_repeat/screen/item_detail/item_detail_screen.dart';
import 'package:carrot_repeat/util/default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _likes;
  bool hi;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  bool _isLiked;
  Future<int> getInt() {
    return FirebaseFirestore.instance.collection('Items').snapshots().length;
  }

  String selectedPlace = "수유동";
  final storeLength =
      FirebaseFirestore.instance.collection('Items').snapshots().length;
  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   await _firestore.collection('Items').doc(_auth.currentUser.uid).set({
    //     "likes": [],
    //   });
    // });
    print(storeLength);
    super.initState();
  }

  @override
  Widget appBarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {},
        child: PopupMenuButton<String>(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              0),
          offset: Offset(0, 50),
          initialValue: selectedPlace,
          onSelected: (value) {
            setState(() {
              selectedPlace = value;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: '수유동', child: Text('수유동')),
              PopupMenuItem(value: '미아동', child: Text('미아동')),
              PopupMenuItem(value: '길음동', child: Text('길음동')),
            ];
          },
          child: Row(
            children: [
              Text(selectedPlace),
              Icon(
                Icons.expand_more,
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () async {
              print(selectedPlace);
              final data = await FirebaseFirestore.instance
                  .collection('Items')
                  .where('place', isEqualTo: selectedPlace)
                  .get();
              print(data.docs.length);
            }),
        IconButton(
            icon: Icon(Icons.tune, color: Colors.black), onPressed: null),
        IconButton(
          onPressed: () async {
            int val = await getInt();
            print(val);
          },
          icon: SvgPicture.asset(
            'assets/svg/bell.svg',
            width: 22,
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    final loginProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    final provider = Provider.of<ItemProvider>(context, listen: false);
    final currentUserId = user.uid;

    return Scaffold(
      appBar: appBarWidget(),
      body: HawkFabMenu(
        icon: AnimatedIcons.add_event,
        fabColor: kMainColor,
        iconColor: Colors.white,
        items: [
          HawkFabMenuItem(
            label: '동네홍보',
            ontap: () {
              loginProvider.logout();
              Scaffold.of(context)..hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('ui가 없습니')),
              );
            },
            icon: Icon(Icons.home),
            color: kMainColor,
            labelColor: Colors.black,
          ),
          HawkFabMenuItem(
            label: '중고거래',
            ontap: () {
              Navigator.pushNamed(context, AddItem.id);
              Scaffold.of(context).hideCurrentSnackBar();
            },
            icon: Icon(FontAwesomeIcons.pen),
            color: kMainColor,
            labelColor: Colors.black,
          ),
        ],
        body: Container(
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Items')
                  .where('place', isEqualTo: selectedPlace)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        provider.selectedId = snapshot.data.docs[index].id;

                        // Navigator.pushNamed(context, ItemDetail.id);
                        Navigator.pushNamed(context, ItemDetail.id);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                snapshot.data.docs[index].data()['image'],
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?.docs[index]
                                              .data()['title'] ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      snapshot.data.docs[index].data()['place'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${NumberFormat('###,###,### 원').format(int.parse(snapshot.data?.docs[index].data()['price'] ?? ''))}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // Text(
                                    //   '${NumberFormat('###,###,### 원').format(int.parse(snapshot.data?.docs[index].data()['price'] ?? ''))}',
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w700),
                                    // ),
                                    Text(
                                        '${DateFormat('yyyy.MM.dd').format(DateTime.now())}' ??
                                            ''),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          StreamBuilder(
                                              stream: _firestore
                                                  .collection('user')
                                                  .doc(_auth.currentUser.uid)
                                                  .snapshots(),
                                              builder: (context, userSnapshot) {
                                                DocumentSnapshot ds =
                                                    snapshot.data.docs[index];
                                                if (userSnapshot.hasError) {
                                                  return Text('Error');
                                                }
                                                if (userSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                }
                                                return IconButton(
                                                  onPressed: () async {
                                                    provider.selectedId =
                                                        snapshot.data
                                                            .docs[index].id;
                                                    if (snapshot
                                                        .data.docs[index]
                                                        .data()['boolinga']
                                                        .contains(user.uid)) {
                                                      await _firestore
                                                          .collection('user')
                                                          .doc(_auth
                                                              .currentUser.uid)
                                                          .update({
                                                        "likes": FieldValue
                                                            .arrayRemove([
                                                          provider.selectedId
                                                        ])
                                                      });
                                                      await ds.reference
                                                          .update({
                                                        'boolinga': FieldValue
                                                            .arrayRemove(
                                                                [user.uid])
                                                      });
                                                      await ds.reference
                                                          .update({
                                                        'likes': FieldValue
                                                            .increment(-1)
                                                      });
                                                    } else if (!snapshot
                                                        .data.docs[index]
                                                        .data()['boolinga']
                                                        .contains(user.uid)) {
                                                      await _firestore
                                                          .collection('user')
                                                          .doc(_auth
                                                              .currentUser.uid)
                                                          .update({
                                                        "likes": FieldValue
                                                            .arrayUnion([
                                                          provider.selectedId
                                                        ])
                                                      });
                                                      await ds.reference
                                                          .update({
                                                        'boolinga': FieldValue
                                                            .arrayUnion(
                                                                [user.uid])
                                                      });
                                                      await ds.reference
                                                          .update({
                                                        'likes': FieldValue
                                                            .increment(1)
                                                      });
                                                    }
                                                    // snapshot.data.docs[index].data()['likes'] < 0 ?
                                                    // await ds.reference
                                                    //     .update({
                                                    //   'likes': FieldValue
                                                    //       .(1)
                                                    // });
                                                  },
                                                  icon: Icon(
                                                      snapshot.data.docs[index]
                                                              .data()[
                                                                  'boolinga']
                                                              .contains(
                                                                  user.uid)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      size: 24,
                                                      color: kMainColor),
                                                );
                                              }),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(snapshot.data.docs[index]
                                                      .data()['likes'] >=
                                                  1
                                              ? '${snapshot.data.docs[index].data()['likes']}'
                                              : ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      height: 1,
                      color: Color(0xFFEAECEB),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
