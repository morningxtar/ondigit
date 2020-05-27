
import 'package:flutter/material.dart';


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
                image: AssetImage("assets/images/drawerhead.jpg"),
                    fit: BoxFit.contain)
            ),
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
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context) => Statistiques()),
//                );
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
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context) => Notifications()),
//                );
              },
              leading: Icon(
                Icons.history,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: new ListTile(
              title: new Text(
                'Vérifier réservatio',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color.fromRGBO(75, 75, 75, 0.8)),
              ),
              onTap: () {
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context) => Notifications()),
//                );
              },
              leading: Icon(
                Icons.history,
                color: Color.fromRGBO(71, 71, 70, 0.8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
