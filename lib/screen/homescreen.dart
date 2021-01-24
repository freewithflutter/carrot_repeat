import 'package:carrot_repeat/components/temparature.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/additem/additem_screen.dart';
import 'package:carrot_repeat/screen/item_detail/item_detail_screen.dart';
import 'package:carrot_repeat/util/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class A {
//   Future<int> getInt() {
//     return FirebaseFirestore.instance.collection('Items').snapshots().length;
//   }
// }
//
// class B {
//   checkValue() async {
//     final val = await A().getInt();
//   }
// }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  Future<int> getInt() {
    return FirebaseFirestore.instance.collection('Items').snapshots().length;
  }

  Stream<int> hi = FirebaseFirestore.instance
      .collection('Items')
      .snapshots()
      .length
      .asStream();

  checkValue() async {
    int val = await getInt();
  }

  getCount() {
    return FirebaseFirestore.instance.collection('Items').snapshots().length;
  }

  String selectedPlace = "수유동";
  final storeLength =
      FirebaseFirestore.instance.collection('Items').snapshots().length;
  @override
  void initState() {
    // print(store.collection('Items').doc('title'));
    print(storeLength);
    super.initState();
  }

  @override
  Widget appBarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {
          setState(() {});
        },
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
              print(selectedPlace);
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
    final provider = Provider.of<ItemProvider>(context, listen: false);
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
              builder: (context, itemRe) {
                if (itemRe.hasError) {
                  return Text('Error');
                }
                if (itemRe.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        provider.selectedId = itemRe.data.docs[index].id;
                        Navigator.pushNamed(context, ItemDetail.id);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                itemRe.data?.docs[index].data()['image'] ?? '',
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
                                      itemRe.data?.docs[index]
                                              .data()['title'] ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      itemRe.data.docs[index].data()['place'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500),
                                    ),
                                    SizedBox(
                                      height: 6,
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
                                          SvgPicture.asset(
                                            'assets/svg/heart_off.svg',
                                            width: 14,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(itemRe.data.docs[index]
                                              .data()['likes']),
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
                  itemCount: itemRe.data.docs.length,

                  // separatorBuilder: (BuildContext context, int index) {
                  //   return Container(
                  //     margin: EdgeInsets.symmetric(vertical: 12),
                  //     height: 1,
                  //     color: Color(0xFFEAECEB),
                  //   );
                  // },
                );
              }),
        ),
      ),
    );
  }
}
