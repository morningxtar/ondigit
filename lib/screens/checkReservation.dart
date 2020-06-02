import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appbar.dart';
import '../drawer.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:encrypt/encrypt.dart' as encrypt;

class CheckSreen extends StatefulWidget {

  @override
  CheckSreenState createState() => new CheckSreenState();
}

class CheckSreenState extends State<CheckSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  String cameraScanResult;
  Color color;
  List tab = [];
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setState(() {
      color = Colors.white;
      check();
    });

  }

  Future<bool> check() async {
    String cameraScanResult = await scanner.scan();
//    final key = encrypt.Key.fromUtf8('my 32 length key................');
//    final iv = IV.fromLength(16);
//    final encrypter = Encrypter(AES(key));
//    final decrypted = encrypter.decrypt(Encrypted.fromBase64(cameraScanResult), iv: iv);

    setState(() {
      color = Colors.green;
      tab = cameraScanResult.split(',');
    });
  return tab[6] == true;
  }

  Widget checkScreen(){
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              )),
        ),
        Container(

          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Container(
                color: Colors.green,
                ),
                RaisedButton(

                  onPressed: () {
                    check();
                  },
                  //since this is only a UI app
                  child: Text(
                    'SCAN',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.blue,
                  elevation: 0,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(key: _scaffoldKey,
        drawer: drawer(context),
        appBar: appbar('Vérifier réservation'),
        body: checkScreen());
  }
}
