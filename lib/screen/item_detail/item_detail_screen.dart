import 'package:carrot_repeat/provider/item_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Items')
              .doc(provider.selectedId)
              .snapshots(),
          builder: (context, snapshot) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.network(
                    snapshot.data.data()['image'],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
