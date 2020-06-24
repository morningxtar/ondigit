import 'package:flutter/material.dart';
import 'package:ondigit/screens/checkReservation.dart';
import 'package:ondigit/screens/historiqueReservation.dart';
import 'package:ondigit/screens/login.dart';
import 'package:ondigit/screens/reservationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(BuildContext context, String userType) {
  return SizedBox(
    width: 300,
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover)),
            child: null,
          ),
          Visibility(
            visible: userType != 'virgile',
            child: new ListTile(
              title: Text(
                "Réserver place",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ReservationSreen()),
                );
              },
              leading: Icon(
                Icons.add_box,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
          Visibility(
            visible: userType != 'virgile',
            child: new ListTile(
              title: new Text(
                'Historique des réservations',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoriqueReservationSreen()),
                );
              },
              leading: Icon(
                Icons.history,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
          Visibility(
            visible: userType == 'virgile',
            child: Builder(
              builder: (context) => ListTile(
                title: new Text(
                  'Vérifier réservation',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Color.fromRGBO(75, 75, 75, 0.8)),
                ),
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckSreen()),
                  );
                },
                leading: Icon(
                  Icons.scanner,
                  color: Color.fromRGBO(71, 71, 70, 0.8),
                ),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: new ListTile(
              title: new Text(
                'Déconnexion',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
                logout(context);
              },
              leading: Icon(
                Icons.subdirectory_arrow_left,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

SharedPreferences _sharedPreferences;

logout(BuildContext context) async {
  _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.clear();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginSreen()),
  );
}
