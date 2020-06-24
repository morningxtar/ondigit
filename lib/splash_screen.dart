import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ondigit/screens/checkReservation.dart';
import 'package:ondigit/screens/login.dart';
import 'package:ondigit/utils/navigation_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/reservationScreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences _sharedPreferences;
  String userType;

  @override
  void initState() {
    super.initState();
    instancingSharedPref();
    Timer(Duration(seconds: 3), () {
      isConnected().then((value) {
        if (value) {
          userType != 'virgile' ? NavigationUtils.pushReplacement(context, ReservationSreen())
              : NavigationUtils.pushReplacement(context, CheckSreen());
        }
            else NavigationUtils.pushReplacement(context, LoginSreen());
      });
    });
  }

  Future<bool> isConnected() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.containsKey('user');
  }

  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userType = _sharedPreferences.getString('userType');
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
