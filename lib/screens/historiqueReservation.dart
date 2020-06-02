import 'package:encrypt/encrypt.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/appbar.dart';
import 'package:ondigit/drawer.dart';
import 'package:ondigit/models/Login.dart';
import 'package:ondigit/models/Place.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/screens/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../ondigit.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class HistoriqueReservationSreen extends StatefulWidget {
  @override
  HistoriqueReservationState createState() => new HistoriqueReservationState();
}

class HistoriqueReservationState extends State<HistoriqueReservationSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  Future<List<Place>> futurePlaces;


  instancingSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      futurePlaces = getReservation(_sharedPreferences.getString('email'));
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    instancingSharedPref();
  }

  Widget historiquereservationScreen() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Container(
      child: FutureBuilder<List<Place>>(
        future: futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Place place = snapshot.data[index];
                  return Column(
                    children: <Widget>[
                      // Widget to display the list of project
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: (){

                            (place.access == true) ?  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final key = encrypt.Key.fromUtf8('my 32 length key................');
                                  final iv = IV.fromLength(16);
                                  final encrypter = Encrypter(AES(key));
                                  final encrypted = encrypter.encrypt(place.id.toString(), iv: iv);
                                  return AlertDialog(
                                    backgroundColor: (place.access == true) ? Colors.green : Colors.red,
                                    content: QrImage(
                                      data: place.id.toString() + ',' + place.userEmail.toString() + ',' + place.timeReservation.toString() + ',' + place.dateReservation.toString() + ',' + place.computerNumber.toString() + ',' + place.serviceType.toString() + ',' + place.access.toString(),
                                      version: QrVersions.auto,
                                    ),
                                  );
                                }) : Container();
                          },
                          child: Card(color: (place.access == true) ? Colors.green : Colors.red,
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Service : '+ place.serviceType),
                                Text('Machine : '+ place.computerNumber),
                                Text('Date réservation : '+ place.dateReservation),
                                Text('Heure réservation : '+ place.timeReservation),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        appBar: appbar('Historique des réservations'),
        body: historiquereservationScreen());
  }
}
