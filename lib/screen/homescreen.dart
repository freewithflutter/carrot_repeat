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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedPlace = "수유동";

  @override
  void initState() {
    final store = FirebaseFirestore.instance;
    print(store.collection('Items').doc('title'));
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
            icon: Icon(Icons.search, color: Colors.black), onPressed: null),
        IconButton(
            icon: Icon(Icons.tune, color: Colors.black), onPressed: null),
        IconButton(
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
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          provider.selectedId = snapshot.data.docs[index].id;
                          Navigator.pushNamed(context, ItemDetail.id);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              ClipRRect(
                                child: Hero(
                                  tag:
                                      snapshot.data.docs[index].data()['image'],
                                  child: Image.network(
                                    snapshot.data.docs[index].data()['image'],
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data.docs[index]
                                            .data()['title'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        provider.itemLists[index].place,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade500),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        '${NumberFormat('###,###,### 원').format(int.parse(snapshot.data.docs[index].data()['price']))}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                          '${DateFormat('yyyy.MM.dd').format(DateTime.now())}'),
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
                                            Text(provider
                                                .itemLists[index].likes),
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
                } else {
                  return Container(
                    child: Center(
                      child: Text('해당지역에 상품이 없습니다'),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
