import 'package:flutter/material.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/models/Login.dart';
import 'package:ondigit/screens/checkReservation.dart';
import 'package:ondigit/screens/historiqueReservation.dart';
import 'package:ondigit/screens/login.dart';
import 'package:ondigit/screens/reservationScreen.dart';
import 'package:qrscan/qrscan.dart' as scanner;

Widget drawer(BuildContext context) {
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
            visible: true,
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
            visible: true,
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
            visible: true,
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
                  String cameraScanResult = await scanner.scan();
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(cameraScanResult),
                    backgroundColor: Colors.blue.shade900,
                    action: SnackBarAction(
                      label: 'retour',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
//                String cameraScanResult = await scanner.scan();
//                print('ui' +cameraScanResult);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CheckSreen(cameraScanResult)),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSreen()),
                );
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
