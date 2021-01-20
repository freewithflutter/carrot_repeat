import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex;
  Widget appBarWidget() {
    return AppBar(
      elevation: 1,
      title: Container(
        child: Row(
          children: [
            Text('아라동'),
            Icon(
              Icons.expand_more,
            ),
          ],
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
        ))
      ],
    );
  }

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/svg/home_on.svg', width: 22),
              icon: SvgPicture.asset('assets/svg/home_off.svg', width: 22),
              label: '홈'),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/svg/notes_on.svg', width: 22),
            icon: SvgPicture.asset('assets/svg/notes_off.svg', width: 22),
            label: '동네생활',
          ),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/svg/home_on.svg', width: 22),
              icon: SvgPicture.asset('assets/svg/home_off.svg', width: 22),
              label: '내 근처'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/svg/home_on.svg', width: 22),
              icon: SvgPicture.asset('assets/svg/home_off.svg', width: 22),
              label: '채팅'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/svg/home_on.svg', width: 22),
              icon: SvgPicture.asset('assets/svg/home_off.svg', width: 22),
              label: '나의 당'),
        ]);
  }

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
      body: Container(
        width: double.infinity,
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Row(
                children: [
                  ClipRRect(
                    child: Image.network(
                      provider.itemLists[index].image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.fill,
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
                            provider.itemLists[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
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
                            '${provider.itemLists[index].price}원',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/heart_off.svg',
                                  width: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(provider.itemLists[index].likes),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: provider.itemLists.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 1,
              color: Color(0xFFEAECEB),
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }
}
