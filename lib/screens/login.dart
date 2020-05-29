import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ondigit/apis/getData.dart';
import 'package:ondigit/models/Login.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/screens/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';


import '../ondigit.dart';

class LoginSreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginSreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  Login _login = Login();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
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
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: loginForm(),
          ),
        ),
      ],
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

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Container(
              color: Color(0xfff5f5f5),
              child: TextFormField(
                style:
                    TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.person_outline),
                    labelStyle: TextStyle(fontSize: 15)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Entrer votre email';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _login.email = value;
                },
              ),
            ),
          ),
          Container(
            color: Color(0xfff5f5f5),
            child: TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  labelStyle: TextStyle(fontSize: 15)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Entrer votre mot de passe';
                }
                return null;
              },
              onSaved: (String value) {
                _login.password = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  setState(() {
                    if (isAuthenticated(_login.email, _login.password)) {
//                      Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context) => InscriptionSreen()),
//                );
                    }

                  });

                }
              },
              //since this is only a UI app
              child: Text(
                'CONNEXION',
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
                      text: "Vous n'avez pas de compte ? ",
                      style: TextStyle(
                        fontFamily: 'SFUIDisplay',
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  TextSpan(
                      text: "Inscrivez vous!",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InscriptionSreen()));
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


  bool isAuthenticated(String email, String password){
    print(check);

    setState(() {
      isValidUser(email, password, context);
    });

    return check;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(key: _scaffoldKey, body: loginScreen());
  }
}
