import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/screens/login.dart';

ThemeData appTheme = ThemeData(
    fontFamily: 'Oxygen'
);

class OnDigit extends StatefulWidget {

  @override
  _OnDigitState createState() => _OnDigitState();
}

class _OnDigitState extends State<OnDigit> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'On Digit',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: new LoginSreen(),
    );
  }
}