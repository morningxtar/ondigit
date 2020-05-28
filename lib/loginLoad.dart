import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ondigit/screens/login.dart';
import 'package:ondigit/screens/reservationScreen.dart';
import 'package:ondigit/utils/navigation_utils.dart';

class LoginLoading extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<LoginLoading> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      NavigationUtils.pushReplacement(context, ReservationSreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loadingScreen()
      ),
    );
  }

  Widget loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
            child: new Column(
              children: <Widget>[
                new CircularProgressIndicator(strokeWidth: 4.0),
                new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    'Authentification en cours...',
                    style:
                    new TextStyle(color: Colors.green, fontSize: 16.0),
                  ),
                )
              ],
            )));
  }
}
