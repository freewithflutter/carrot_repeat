import 'package:carrot_repeat/examdetail.dart';
import 'package:carrot_repeat/examnote.dart';
import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/additem/additem_screen.dart';
import 'package:carrot_repeat/screen/app.dart';
import 'package:carrot_repeat/screen/homescreen.dart';
import 'package:carrot_repeat/screen/item_detail/item_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ItemProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carrot Repeat',
        home: App(),
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        routes: {
          ItemDetail.id: (context) => ItemDetail(),
          AddItem.id: (context) => AddItem(),
          ExamDetail.id: (context) => ExamDetail(),
        },
      ),
    );
  }
}
