import 'package:carrot_repeat/provider/google_sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('loginScreen'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            googleProvider.login();
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text('구글 로그인'),
            ),
          ),
        ),
      ),
    );
  }
}
