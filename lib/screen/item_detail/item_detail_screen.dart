import 'package:carrot_repeat/components/temparature.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/util/default.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItemDetail extends StatefulWidget {
  static final String id = 'itemdetail';

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    final fire = FirebaseFirestore.instance;
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Scaffold(
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
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
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
                      Icon(
                        FontAwesomeIcons.heart,
                        size: 18,
                        color: Colors.grey.shade500,
                      ),
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
                    child: Center(
                      child: Text(
                        '채팅으로 거래하기',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      body: SingleChildScrollView(
        child: StreamBuilder(
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
                                    snapshot.data.data()['sellerId'] ?? '이해주',
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
