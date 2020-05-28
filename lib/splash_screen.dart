import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ondigit/screens/login.dart';
import 'package:ondigit/utils/navigation_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      NavigationUtils.pushReplacement(context, LoginSreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  )
                ],
              ),
            ),
            CircularProgressIndicator(),
            Text("Chargement en cours..."),
            Text("@SaH Analytics International"),
          ],
        ),
      ),
    );
  }
}
