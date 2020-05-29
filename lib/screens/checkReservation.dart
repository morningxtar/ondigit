import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/models/Login.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/screens/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ondigit.dart';

class CheckSreen extends StatefulWidget {
  CheckSreen(String cameraScanResult);

  @override
  CheckSreenState createState() => new CheckSreenState();
}

class CheckSreenState extends State<CheckSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

  }

  Widget checkScreen(){
    return Container();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(key: _scaffoldKey, body: checkScreen());
  }
}
