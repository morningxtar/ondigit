import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/appbar.dart';
import 'package:ondigit/drawer.dart';
import 'package:ondigit/models/Place.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/models/service.dart';
import 'package:ondigit/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ondigit.dart';

class ReservationSreen extends StatefulWidget {
  @override
  ReservationSreenState createState() => new ReservationSreenState();
}

class ReservationSreenState extends State<ReservationSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  var _formKey = GlobalKey<FormState>();
  Place _place = Place();
  Future<List<String>> services;
  List<int> hoursValue = [];
  int year;
  int month;
  int day;
  int hour;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(DateTime.now().millisecondsSinceEpoch);
      year = DateTime.now().year;
      month = DateTime.now().month;
      day = DateTime.now().day;
      day = DateTime.now().hour;
    });
  }

  Widget reservationScreen() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
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
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 23, right: 23, top: 23),
            child: reservationForm(),
          ),
        ),
      ],
    );
  }

  Widget reservationForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(0xfff5f5f5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type de service',
                  prefixIcon: Icon(Icons.local_laundry_service),
                  labelStyle: TextStyle(fontSize: 15)),
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              isExpanded: true,
              isDense: true,
              items: <DropdownMenuItem<dynamic>>[
                DropdownMenuItem(
                  value: "navigation internet",
                  child: Text(
                    "Navigation internet",
                  ),
                ),
              ],
              onChanged: (value) {
                _place.serviceType = value;
              },
              onSaved: (value) {
                _place.serviceType = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: DateTimeField(
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  print(date.millisecondsSinceEpoch);
                  setState(() {
                    hoursControl(date, DateTime.now());
                  });
                }

                return date;
              },
              onSaved: (value){
                print('object' + value.toString());
              },
              onChanged: (value) {
                print('rr'+value.toString());
                _place.dateReservation = value.day.toString() +
                    '-' +
                    value.month.toString() +
                    '-' +
                    value.year.toString();
              },

            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Heure',
                  prefixIcon: Icon(Icons.access_time),
                  labelStyle: TextStyle(fontSize: 15)),
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              isExpanded: true,
              isDense: true,
              items: hoursValue
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                _place.timeReservation = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Liste des machines',
                  prefixIcon: Icon(Icons.computer),
                  labelStyle: TextStyle(fontSize: 15)),
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              isExpanded: true,
              isDense: true,
              items: <DropdownMenuItem<dynamic>>[
                DropdownMenuItem(
                  value: "poste 1",
                  child: Text(
                    "Poste 1",
                  ),
                ),
                DropdownMenuItem(
                  value: "poste 2",
                  child: Text(
                    "Poste 2",
                  ),
                ),
                DropdownMenuItem(
                  value: "poste 3",
                  child: Text(
                    "Poste 3",
                  ),
                ),
              ],
              onChanged: (value) {
                _place.computerNumber = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _place.userEmail = 's';
                  _place.access = 1;
                  print(_place.id);
                  print(_place.serviceType);
                  print(_place.dateReservation);
                  print(_place.timeReservation);
                  print(_place.computerNumber);
                  print(_place.userEmail);
                  print(_place.access);
                }
              },
              //since this is only a UI app
              child: Text(
                'RESERVER',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SFUIDisplay',
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.green,
              elevation: 0,
              minWidth: 400,
              height: 50,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
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
                    new TextStyle(color: Colors.red.shade500, fontSize: 16.0),
              ),
            )
          ],
        )));
  }

  void hoursControl(DateTime dateChosen, DateTime currentDate) {
    int timeOver;
    hoursValue.clear();
    if (dateChosen.day == currentDate.day &&
        dateChosen.month == currentDate.month &&
        dateChosen.year == currentDate.year) {
      if (currentDate.hour <= 16) {
        timeOver = 16 - this.hour;
        this.hoursValue = [];
        for (var i = currentDate.hour; i <= 16; i++) {
          this.hoursValue.add(i);
        }
      } else {
        this.hoursValue = [];
      }
    } else {
      this.hoursValue = [];
      for (var i = 8; i <= 16; i++) {
        this.hoursValue.add(i);
      }
    }
    print(this.hoursValue);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        appBar: appbar('Réservation'),
        body: reservationScreen());
  }
}
