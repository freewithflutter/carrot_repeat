import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:carrot_repeat/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        home: HomeScreen(),
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
