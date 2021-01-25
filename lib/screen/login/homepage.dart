import 'package:carrot_repeat/provider/google_sign_in_provider.dart';
import 'package:carrot_repeat/screen/login/login_screeen.dart';
import 'package:carrot_repeat/screen/login/logindata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final googleprovider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (googleprovider.isSigningIn) {
            return Indicator();
          } else if (snapshot.hasData) {
            return LoginData();
          } else {
            return LoginScreen();
          }
        });
  }

  Widget Indicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
