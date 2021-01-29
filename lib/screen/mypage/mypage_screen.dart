import 'package:carrot_repeat/util/default.dart';
import 'package:flutter/material.dart';

//TODO Favorite item list up
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('관심목록'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              DefaultTabController(
                initialIndex: 0,
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.black,
                      labelStyle: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
                      unselectedLabelColor: kLightGrayBlueColor,
                      labelColor: Colors.black,
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
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: TabBarView(children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.red,
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
