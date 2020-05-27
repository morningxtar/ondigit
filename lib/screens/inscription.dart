import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/models/service.dart';
import 'package:ondigit/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ondigit.dart';

class InscriptionSreen extends StatefulWidget {
  @override
  InscriptioncreenState createState() => new InscriptioncreenState();
}

class InscriptioncreenState extends State<InscriptionSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  var _formKey = GlobalKey<FormState>();
  Inscription _inscription = Inscription();
  Future<List<String>> services;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      services = fetchService();
    });
  }

  Widget loginScreen() {
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
            padding: EdgeInsets.all(23),
            child: inscriptionForm(),
          ),
        ),
      ],
    );
  }

  Widget inscriptionForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              color: Color(0xfff5f5f5),
              child: TextFormField(
                style:
                    TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom',
                    prefixIcon: Icon(Icons.person_outline),
                    labelStyle: TextStyle(fontSize: 15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Champ obligatoire';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _inscription.firstName = value;
                },
              ),
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prénoms',
                  prefixIcon: Icon(Icons.person_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Champ obligatoire';
                }
                return null;
              },
              onSaved: (String value) {
                _inscription.lastName = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Téléphone',
                  prefixIcon: Icon(Icons.smartphone),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Champ obligatoire';
                }
                return null;
              },
              onSaved: (String value) {
                _inscription.phoneNumber = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Champ obligatoire';
                }
                return null;
              },
              onSaved: (String value) {
                _inscription.email = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Champ obligatoire';
                } else if (value.length < 6)
                  return 'Le mot de passe doit être supérieur à 6 caractère';
                return null;
              },
              onFieldSubmitted: (String value) {
                print(value);
              },
              onSaved: (String value) {
                _inscription.password = value;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Répétez le mot de passe',
                  prefixIcon: Icon(Icons.lock_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Champ obligatoire';
                }
                return null;
              },
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type d\'inscription',
                  labelStyle: TextStyle(fontSize: 15)),
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              isExpanded: true,
              isDense: true,
              items: <DropdownMenuItem<dynamic>>[
                DropdownMenuItem(
                  value: "inscription normale",
                  child: Text(
                    "inscription normale",
                  ),
                ),
              ],
              onChanged: (value) {
                _inscription.userType = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              onPressed: () {

                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print(_inscription.userType);
                }
              },
              //since this is only a UI app
              child: Text(
                'INSCRIPTION',
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
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Vous êtes déjà inscrite ? ",
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  TextSpan(
                      text: "Connectez vous!",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSreen()));
                        },
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        color: Colors.blue,
                        fontSize: 15,
                      ))
                ]),
              ),
            ),
          )
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(key: _scaffoldKey, body: loginScreen());
  }
}
