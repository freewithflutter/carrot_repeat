// import 'dart:async';
//
// import 'package:flutter/rendering.dart';
// import 'package:justjam/home.dart';
// import 'package:justjam/model/normalPlace.dart';
// import 'package:justjam/provider/NormalPaceSearch.dart';
// import 'package:justjam/provider/PlaceSearch.dart';
// import 'package:justjam/provider/google_sign_in.dart';
// import 'package:justjam/screens/login/login_mainpage_screen.dart';
// import 'package:justjam/screens/searchitem/normal_place_detail_screen.dart';
// import 'package:justjam/screens/searchitem/search_detail_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_page_indicator/flutter_page_indicator.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:justjam/utill/default.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:justjam/utill/item_lists.dart';
//
// import 'package:provider/provider.dart';
//
// //TODO 홈 화면 페이지
//
// class HomeScreen extends StatefulWidget {
//   static final String id = 'homeScreen';
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final placeSearch = Provider.of<PlaceSearch>(context, listen: true);
//     final normalPlaceSearch =
//     Provider.of<NormalPlaceSearch>(context, listen: false);
//     return Scaffold(
//       body: HomeScreenWidget(
//           placeSearch: placeSearch, normalPlaceSearch: normalPlaceSearch),
//     );
//   }
// }
//
// class HomeScreenWidget extends StatelessWidget {
//   HomeScreenWidget({
//     Key key,
//     @required this.placeSearch,
//     @required this.normalPlaceSearch,
//   }) : super(key: key);
//
//   final PlaceSearch placeSearch;
//   final NormalPlaceSearch normalPlaceSearch;
//   final user = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     flex: 7,
//                     child: SizedBox(
//                       height: 40,
//                       width: 350,
//                       child: TextField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 10),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 1, color: klightGrayBlueColor),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 1, color: klightGrayBlueColor),
//                           ),
//                           hintText: '지역,지하철역으로 검색하세요',
//                           hintStyle: TextStyle(color: kSearchTextColor),
//                           suffixIcon: FlatButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                               final google = Provider.of<GoogleSignInProvider>(
//                                   context,
//                                   listen: false);
//                               google.logout();
//                             },
//                             child: Icon(
//                               Icons.search,
//                               color: kMainColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: FlatButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, LoginMain.id);
//                       },
//                       child: Icon(
//                         Icons.map_outlined,
//                         color: kMainColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: Colors.white,
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 10),
//                     height: 255,
//                     child: new Swiper(
//                       itemBuilder: (context, index) => Container(
//                         alignment: Alignment.topLeft,
//                         margin: EdgeInsets.only(
//                           bottom: 10,
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: new Image.asset(
//                             'assets/images/mainpopup.png',
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                       itemCount: 5,
//                       viewportFraction: 1,
//                       pagination: new SwiperPagination(
//                         margin: new EdgeInsets.all(5.0),
//                       ),
//                       indicatorLayout: PageIndicatorLayout.NONE,
//                       scale: 0.9,
//                       control: SwiperControl(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   // Container(
//                   //   height: 200,
//                   //   child: Center(
//                   //       child: Text(user.displayName),
//                   //       ),
//                   // ),
//
//                   Container(
//                     padding: EdgeInsets.only(left: 0),
//                     width: double.infinity,
//                     height: 250,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       primary: false,
//                       itemCount: 2,
//                       itemBuilder: (context, index) => popUpLists[index],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: 12,
//               width: double.infinity,
//               color: ksizedBoxColor,
//             ), //Section 1
//             // TODO section1 ends, 2 starts
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '플랜즈 커피 공간',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Icon(
//                         FontAwesomeIcons.questionCircle,
//                         color: Colors.grey,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 20),
//                     child: DefaultTabController(
//                       length: 2,
//                       initialIndex: 0,
//                       child: Column(
//                         children: [
//                           Container(
//                             child: TabBar(
//                               indicatorColor: kMainColor,
//                               labelColor: kMainColor,
//                               labelStyle:
//                               TextStyle(fontWeight: FontWeight.bold),
//                               unselectedLabelColor: Color(0xFF4F4F4F),
//                               unselectedLabelStyle: TextStyle(
//                                 fontWeight: FontWeight.w300,
//                               ),
//                               tabs: [
//                                 Tab(
//                                   child: Text(
//                                     '플랜즈 공간',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                 ),
//                                 Tab(
//                                   child: Text(
//                                     '일반공간',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 top: BorderSide(
//                                   width: 1,
//                                   color: Color(0xFFDADADA),
//                                 ),
//                                 bottom: BorderSide(
//                                   width: 1,
//                                   color: Color(0xFFDADADA),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ConstrainedBox(
//                             constraints: BoxConstraints(
//                               maxWidth: double.infinity,
//                               maxHeight: 480,
//                               // maxHeight:
//                               //     MediaQuery.of(context).size.height * 0.6),
//                             ),
//                             child: TabBarView(
//                               children: [
//                                 Container(
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Expanded(
//                                         child: GridView.builder(
//                                             padding: EdgeInsets.zero,
//                                             gridDelegate:
//                                             SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
//                                                 crossAxisCount: 2,
//                                                 crossAxisSpacing: 10,
//                                                 mainAxisSpacing: 10,
//                                                 height: 230),
//                                             itemCount: 4,
//                                             physics:
//                                             NeverScrollableScrollPhysics(),
//                                             scrollDirection: Axis.vertical,
//                                             itemBuilder: (context, index) {
//                                               final place =
//                                               placeSearch.placeList[index];
//                                               return FlanzItem(
//                                                   image: place.image,
//                                                   name: place.name,
//                                                   location: place.location,
//                                                   price: place.price,
//                                                   aim: place.aim,
//                                                   onTap: () {
//                                                     placeSearch.selectedPlace =
//                                                     placeSearch
//                                                         .placeList[index];
//                                                     Navigator.pushNamed(context,
//                                                         SearchDetailScreen.id);
//                                                   });
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                   padding: EdgeInsets.only(top: 10),
//                                 ),
//                                 Container(
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         child: GridView.builder(
//                                           padding: EdgeInsets.zero,
//                                           gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
//                                             crossAxisCount: 2,
//                                             mainAxisSpacing: 10,
//                                             crossAxisSpacing: 10,
//                                             height: 230,
//                                           ),
//                                           itemCount: 4,
//                                           physics:
//                                           NeverScrollableScrollPhysics(),
//                                           scrollDirection: Axis.vertical,
//                                           itemBuilder: (context, index) {
//                                             final normal = normalPlaceSearch
//                                                 .normalPlaceLists[index];
//                                             return FlanzRightItem(
//                                               onTap: () {
//                                                 normalPlaceSearch
//                                                     .selectedPlace =
//                                                 normalPlaceSearch
//                                                     .normalPlaceLists[
//                                                 index];
//                                                 Navigator.pushNamed(
//                                                     context,
//                                                     NormalPlaceSearchDetailScreen
//                                                         .id);
//                                               },
//                                               image: normal.image,
//                                               title: normal.title,
//                                               place: normal.place,
//                                               price: normal.price,
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   padding: EdgeInsets.only(top: 10),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // TODO section2 ends, 3 starts
//             Container(
//               height: 12,
//               color: ksizedBoxColor,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '기타',
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/drink.png'),
//                             ),
//                             shape: BoxShape.circle,
//                             border: Border.all(width: 1, color: Colors.red),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           '음료소개',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image:
//                               AssetImage('assets/images/thecondlogo.png'),
//                             ),
//                             shape: BoxShape.circle,
//                             border: Border.all(width: 1, color: kMainColor),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           '회사소개',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/advice.png'),
//                             ),
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                                 width: 1, color: klightGrayBlueColor),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           '개설상담',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// List<Widget> popUpLists = [
//   PopUp1(),
//   PopUp2(),
// ];
//
// class PopUp1 extends StatelessWidget {
//   const PopUp1({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       child: Row(
//         children: [
//           Container(
//             width: 300,
//             height: 234,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                   image: AssetImage('assets/images/popupre1.png'),
//                   fit: BoxFit.cover),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text.rich(
//                         TextSpan(
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: user.displayName,
//                               style: TextStyle(
//                                   color: Color(0xFF50555C),
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                             TextSpan(
//                               text: '님',
//                               style: TextStyle(
//                                   color: Color(0xFF50555C),
//                                   fontSize: 26,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         '음료 발행까지',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Color(0xFF50555C),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 200,
//                   child: FlatButton(
//                     padding: EdgeInsets.zero,
//                     child: Container(
//                       height: 30,
//                       width: 86,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: kMainColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           '확인하기',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 30,
//                   left: 120,
//                   child: Text.rich(
//                     TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: '1',
//                           style: TextStyle(
//                               color: Color(0xFF50555C),
//                               fontWeight: FontWeight.w900,
//                               fontSize: 120),
//                         ),
//                         TextSpan(
//                             text: '장의',
//                             style: TextStyle(
//                               color: Color(0xFF50555C),
//                               fontSize: 26,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 170,
//                   left: 135,
//                   child: Text(
//                     '스티커가 남아습니다',
//                     style: TextStyle(
//                       color: Color(0xFF50555C),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PopUp2 extends StatelessWidget {
//   const PopUp2({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           Container(
//             width: 300,
//             height: 234,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                   image: AssetImage('assets/images/popupre1.png'),
//                   fit: BoxFit.cover),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'null',
//                         style: TextStyle(
//                             color: Color(0xFF50555C),
//                             fontSize: 26,
//                             fontWeight: FontWeight.w400),
//                       ),
//                       Text(
//                         '음료 발행까지',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Color(0xFF50555C),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 200,
//                   child: FlatButton(
//                     padding: EdgeInsets.zero,
//                     child: Container(
//                       height: 30,
//                       width: 86,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: kMainColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           '확인하기',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 30,
//                   left: 120,
//                   child: Text.rich(
//                     TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: '1',
//                           style: TextStyle(
//                               color: Color(0xFF50555C),
//                               fontWeight: FontWeight.w900,
//                               fontSize: 120),
//                         ),
//                         TextSpan(
//                             text: '장의',
//                             style: TextStyle(
//                               color: Color(0xFF50555C),
//                               fontSize: 26,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 170,
//                   left: 135,
//                   child: Text(
//                     '스티커가 남아습니다',
//                     style: TextStyle(
//                       color: Color(0xFF50555C),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //oirginal image pop up
// // class Popup extends StatelessWidget {
// //   const Popup({
// //     Key key,
// //     this.popup,
// //   }) : super(key: key);
// //   final PopupLists popup;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(8),
// //       child: Container(
// //         margin: EdgeInsets.only(right: 10),
// //         child: new Image.asset(
// //           popup.image,
// //           width: 340,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }
// // }
// // class Popup extends StatelessWidget {
// //   const Popup({
// //     Key key,
// //     this.popup,
// //   }) : super(key: key);
// //   final PopupLists popup;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(8),
// //       child: Container(
// //         margin: EdgeInsets.only(right: 10),
// //         child: new Image.asset(
// //           popup.image,
// //           width: 340,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
// class FlanzItem extends StatelessWidget {
//   const FlanzItem({
//     Key key,
//     @required this.name,
//     @required this.location,
//     @required this.price,
//     this.image,
//     this.aim,
//     this.onTap,
//   }) : super(key: key);
//   final String image;
//   final String name;
//   final String location;
//   final int price;
//   final int aim;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//               width: 200,
//               height: 140,
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 10),
//               child: Text(
//                 name,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 Icon(Icons.location_on_outlined, color: klightGrayBlueColor),
//                 Text(location)
//               ],
//             ),
//             Container(
//               width: 200,
//               alignment: Alignment.bottomRight,
//               child: Text.rich(
//                 TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '$price',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: kMainColor,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '원/시간',
//                       style: TextStyle(
//                         fontSize: 17,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FlanzRightItem extends StatelessWidget {
//   const FlanzRightItem({
//     Key key,
//     @required this.image,
//     @required this.title,
//     @required this.place,
//     @required this.price,
//     @required this.onTap,
//   }) : super(key: key);
//   final String image, title, place, price;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//               width: 200,
//               height: 140,
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 10),
//               child: Text(
//                 title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 Icon(Icons.location_on_outlined, color: klightGrayBlueColor),
//                 Text(place),
//               ],
//             ),
//             Center(
//               child: Center(
//                 child: Container(
//                   alignment: Alignment.bottomRight,
//                   child: Text.rich(
//                     TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: price,
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: kMainColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ItemLists {
//   final String image, title, place, price;
//   ItemLists({
//     this.image,
//     this.title,
//     this.place,
//     this.price,
//   });
// }
//
// List<ItemLists> items = [
//   ItemLists(
//     title: "그루스터디카페",
//     price: "2000",
//     place: "월곡역",
//     image: "assets/images/item1.jpg",
//   ),
//   ItemLists(
//     title: "델리에 파티",
//     price: "4000",
//     place: "건대입구역",
//     image: "assets/images/item2.jpeg",
//   ),
//   ItemLists(
//     title: "위워크 성수역점",
//     price: "3500",
//     place: "성수역",
//     image: "assets/images/item3.jpg",
//   ),
//   ItemLists(
//     title: "팝스터디카페",
//     price: '2500',
//     place: "수유역",
//     image: "assets/images/item4.jpg",
//   ),
// ];
//
// class ItemRightLists {
//   final String image, title, place, price;
//   final int aim;
//   ItemRightLists({
//     this.image,
//     this.title,
//     this.place,
//     this.price,
//     this.aim,
//   });
// }
//
// List<ItemRightLists> rightItems = [
//   ItemRightLists(
//     title: "경희대 본관(3층)",
//     price: "무료입장",
//     place: "경희대역",
//     image: "assets/images/rightitem.jpg",
//   ),
//   ItemRightLists(
//     title: "가천대 새롬관(1층)",
//     price: "무료입장",
//     place: "가천대역",
//     image: "assets/images/rightitem2.jpg",
//   ),
//   ItemRightLists(
//     title: "위워크 강남(1층 로비)",
//     price: "회원입장",
//     place: "강남역",
//     image: "assets/images/rightitem3.jpg",
//   ),
//   ItemRightLists(
//     title: "국민대 IT관(로비)",
//     price: "무료입장",
//     place: "길음역",
//     image: "assets/images/rightitme4.jpg",
//   ),
// ];
//
// class SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight
//     extends SliverGridDelegate {
//   /// Creates a delegate that makes grid layouts with a fixed number of tiles in
//   /// the cross axis.
//   ///
//   /// All of the arguments must not be null. The `mainAxisSpacing` and
//   /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
//   /// and `childAspectRatio` arguments must be greater than zero.
//   const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight({
//     @required this.crossAxisCount,
//     this.mainAxisSpacing = 0.0,
//     this.crossAxisSpacing = 0.0,
//     this.height = 56.0,
//   })  : assert(crossAxisCount != null && crossAxisCount > 0),
//         assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
//         assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
//         assert(height != null && height > 0);
//
//   /// The number of children in the cross axis.
//   final int crossAxisCount;
//
//   /// The number of logical pixels between each child along the main axis.
//   final double mainAxisSpacing;
//
//   /// The number of logical pixels between each child along the cross axis.
//   final double crossAxisSpacing;
//
//   /// The height of the crossAxis.
//   final double height;
//
//   bool _debugAssertIsValid() {
//     assert(crossAxisCount > 0);
//     assert(mainAxisSpacing >= 0.0);
//     assert(crossAxisSpacing >= 0.0);
//     assert(height > 0.0);
//     return true;
//   }
//
//   @override
//   SliverGridLayout getLayout(SliverConstraints constraints) {
//     assert(_debugAssertIsValid());
//     final double usableCrossAxisExtent =
//         constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
//     final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
//     final double childMainAxisExtent = height;
//     return SliverGridRegularTileLayout(
//       crossAxisCount: crossAxisCount,
//       mainAxisStride: childMainAxisExtent + mainAxisSpacing,
//       crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
//       childMainAxisExtent: childMainAxisExtent,
//       childCrossAxisExtent: childCrossAxisExtent,
//       reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
//     );
//   }
//
//   @override
//   bool shouldRelayout(
//       SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight oldDelegate) {
//     return oldDelegate.crossAxisCount != crossAxisCount ||
//         oldDelegate.mainAxisSpacing != mainAxisSpacing ||
//         oldDelegate.crossAxisSpacing != crossAxisSpacing ||
//         oldDelegate.height != height;
//   }
// }
