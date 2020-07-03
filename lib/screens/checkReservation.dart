import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/models/Place.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appbar.dart';
import '../drawer.dart';
import 'package:intl/intl.dart';
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
  String userType;
  bool enter;

  @override
  void initState() {
    // TODO: implement initState
    instancingSharedPref();
    super.initState();
  }

  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userType = _sharedPreferences.getString('userType');
    });
  }

  check() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('d-M-yyyy');
    String formatted = formatter.format(now);
    String cameraScanResult = await scanner.scan();
    enter = false;
    tab = decryptString(cameraScanResult).split(',');
    print('tab ' + tab.toString());
    print(formatted == tab[3]);
    if (formatted == tab[4] && (now.hour - int.parse(tab[2]) >= 0)) {
      Place place = new Place();
      place.id = int.parse(tab[0]);
      place.serviceType = tab[6];
      place.userEmail = tab[1];
      place.timeReservation = tab[2] + ',' + tab[3];
      place.dateReservation = tab[4];
      place.computerNumber = tab[5];
      place.access = true;
      place.presence = true;
      changeAccess(place);
      enter = true;
    }

    return tab;
  }

  Widget checkScreen() {
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
                Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      check();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 10),
                        content: (enter)
                            ? Text('Vous occuperez le ' +
                                tab[4].toString() +
                                ' de ' +
                                tab[2] +
                                'à' +
                                (int.parse(tab[2]) + 1).toString() +
                                'h')
                            : Text(
                                'Votre réservation n\'est pas pour aujourd\'hui'),
                        backgroundColor: (enter)
                            ? Colors.green.shade500
                            : Colors.red.shade500,
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  decryptString(encrypted) {
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(Encrypted.from64(encrypted), iv: iv);
    return decrypted;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context, userType),
        appBar: appbar('Vérifier réservation'),
        body: checkScreen());
  }
}
