// import 'dart:io';
// import 'dart:math';
//
// import 'package:carrot_repeat/util/default.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// // ignore: must_be_immutable
// class AddItem extends StatefulWidget {
//   static final String id = 'addItem';
//   String _error = 'No Error Dectected';
//   @override
//   _AddItemState createState() => _AddItemState();
// }
//
// class _AddItemState extends State<AddItem> {
//   File _carrotImage;
//   var _pickCarrot = ImagePicker();
//   Future<void> selectImage() async {
//     final aim = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _carrotImage = aim;
//     });
//   }
//
//   String imageUrl;
//   TextEditingController aboutItem = TextEditingController();
//   TextEditingController title = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController place = TextEditingController();
//   TextEditingController image = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(44.0),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1,
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               margin: EdgeInsets.only(top: 14, left: 17),
//               child: Text(
//                 '닫기',
//                 style: TextStyle(fontSize: 16, color: kBlackColor),
//               ),
//             ),
//           ),
//           title: Text(
//             '중고거래 글쓰기',
//             style: TextStyle(
//                 color: kBlackColor, fontSize: 18, fontWeight: FontWeight.w800),
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 Map<String, dynamic> data = {
//                   'title': title.text,
//                   'aboutItem': aboutItem.text,
//                   'price': price.text,
//                   'place': place.text,
//                   'image': imageUrl.toString(),
//                 };
//                 uploadImage();
//                 FirebaseFirestore.instance.collection('Items').add(data);
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: 14, right: 17),
//                 child: Text(
//                   '완료',
//                   style: TextStyle(fontSize: 16, color: kBlackColor),
//                 ),
//               ),
//             ),
//           ],
//           iconTheme: IconThemeData(
//             color: kBlackColor,
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         height: 50,
//         decoration: BoxDecoration(
//             border: Border(
//                 top: BorderSide(
//                   width: 1,
//                   color: kSeperateLineColor,
//                 ))),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Text('게시글 보여줄 동네 고르기'),
//                 Icon(Icons.keyboard_arrow_down)
//               ],
//             ),
//             GestureDetector(
//                 onTap: () {
//                   print(imageUrl);
//                 },
//                 child: Icon(Icons.sticky_note_2_outlined))
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 //TODO upload image
//                 onTap: () {
//                   // uploadImage();
//                   selectImage();
//                 },
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: 30),
//                       width: 64,
//                       height: 64,
//                       decoration: BoxDecoration(
//                           border:
//                           Border.all(width: 1, color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(4)),
//                       child: Center(
//                           child: Icon(
//                             Icons.camera_alt,
//                             color: kLightGrayBlueColor,
//                           )),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     //TODO Image show here
//                     Container(
//                       margin: EdgeInsets.only(top: 30),
//                       decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(4)),
//                       width: 64,
//                       height: 64,
//                       child: Container(
//                         child: _carrotImage == null
//                             ? Center(
//                           child: Container(),
//                         )
//                             : Image.file(
//                           _carrotImage,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//
//                       // Image.file(image),
//
//                       // Image.network(
//                       //   imageUrl.toString(),
//                       //   fit: BoxFit.fill,
//                       // ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//                 width: double.infinity,
//                 height: 1,
//                 color: kSeperateLineColor,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: TextFormField(
//                   controller: title,
//                   decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       hintText: '글 제목',
//                       hintStyle:
//                       TextStyle(fontSize: 18, color: kLightGrayBlueColor)),
//                 ),
//               ),
//               Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   margin: EdgeInsets.symmetric(vertical: 10),
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom:
//                           BorderSide(width: 1, color: kSeperateLineColor))),
//                   child: Container(
//                     padding: EdgeInsets.only(bottom: 4),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '카테고리 선택',
//                           style: TextStyle(fontSize: 18, color: Colors.black87),
//                         ),
//                         GestureDetector(
//                             child: Icon(Icons.keyboard_arrow_right)),
//                       ],
//                     ),
//                   )),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: TextFormField(
//                   controller: price,
//                   decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       hintText: '₩ 가격입력',
//                       hintStyle:
//                       TextStyle(fontSize: 18, color: kLightGrayBlueColor)),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: TextFormField(
//                   controller: place,
//                   decoration: InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: kSeperateLineColor),
//                       ),
//                       hintText: '지역선택',
//                       hintStyle:
//                       TextStyle(fontSize: 18, color: kLightGrayBlueColor)),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: TextFormField(
//                   keyboardType: TextInputType.multiline,
//                   maxLines: null,
//                   controller: aboutItem,
//                   decoration: InputDecoration(
//                       hintMaxLines: 3,
//                       contentPadding: new EdgeInsets.only(bottom: 180.0),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.transparent),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.transparent),
//                       ),
//                       hintText:
//                       '수유2동에 올릴 게시글 내용을 작성해주세요(가품 및 판매금지품목은 게시가 제한될 수 있어요)',
//                       hintStyle: TextStyle(
//                         fontSize: 18,
//                         wordSpacing: 1,
//                         height: 1.2,
//                         color: kLightGrayBlueColor,
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   uploadImage() async {
//     final _storage = FirebaseStorage.instance;
//     final _picker = ImagePicker();
//     PickedFile image;
//
//     // //Select Image
//     // image = await _picker.getImage(source: ImageSource.gallery);
//     var file = File(_carrotImage.path);
//
//     if (_carrotImage != null) {
//       //Upload to Firebase
//
//       int randomNumber = Random().nextInt(10000);
//       String imageLocation = 'item/item${randomNumber}.jpg';
//
//       var snapshot = await _storage.ref().child(imageLocation).putFile(file);
//       var downloadUrl = await snapshot.ref.getDownloadURL();
//
//       await FirebaseFirestore.instance
//           .collection('Items')
//           .doc()
//           .set({'images': downloadUrl});
//
//       setState(() {
//         imageUrl = downloadUrl;
//       });
//     } else {
//       print('No Path Received ㅠㅠ');
//     }
//   }
//
