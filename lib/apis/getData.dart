import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ondigit/constante.dart';
import 'package:ondigit/loginLoad.dart';
import 'package:ondigit/models/Place.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/models/machine.dart';
import 'package:ondigit/models/service.dart';
import 'package:ondigit/screens/inscription.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _sharedPreferences;

List<Service> _services = new List<Service>();
List<Machine> _machine = new List<Machine>();

List<String> _listService = new List();
List<String> _listMachine = new List();
String _listMachines = '';
String _listServices = '';
String responseBody = '';

//fonction qui récupère les intitulés des services de la case numérique
Future<List<String>> fetchService() async {
  final response = await http.get(apiService);
  var dio = new Dio();
  final response1 = await dio.get(apiService);
  _sharedPreferences = await SharedPreferences.getInstance();
  String _listServices = '';
  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for (var i = 0; i < response1.data.length; i++) {
      Service _service = new Service(
        id: response1.data[i]['id'],
        libelle: response1.data[i]['libelle'],
      );
      _listService.add(response1.data[i]['libelle']);
      _services.add(_service);
      _listServices = _listServices + response1.data[i]['libelle'] + ',';
    }
    _sharedPreferences.setString('services', _listServices);
    return _listService;
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

//fonction qui récupère les intitulés des machines de la case numérique
Future<List<Machine>> fetchMachine() async {
  final response = await http.get(apiMachines);
  var dio = new Dio();
  final response1 = await dio.get(apiMachines);
  _sharedPreferences = await SharedPreferences.getInstance();
  _sharedPreferences.remove('machines');
  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    _listMachines = '';
      for (var i = 0; i < response1.data.length; i++) {
        Machine machine = new Machine(
          id: response1.data[i]['id'],
          libelle: response1.data[i]['libelle'],
        );
        //_listMachine.add(response1.data[i]['libelle']);
        _machine.add(machine);
        _listMachines = _listMachines + response1.data[i]['libelle'] + ',';
      }
      print(_listMachines);
      _sharedPreferences.setString('machines', _listMachines);
    return _machine;
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

//fonction qui ajoute un utilisateur
Future<Inscription> createUser(Inscription user) async {
  final http.Response response = await http.post(
    apiCreateUser,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phoneNumber': user.phoneNumber,
      'identity': user.identity,
      'email': user.email,
      'password': user.password,
      'comments': user.comments,
      'userType': user.userType,
    }),
  );
  print(response.body.contains('ConstraintViolationException'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Inscription.fromJson(json.decode(response.body));
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else if (response.statusCode == 500) {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    if (response.body.contains('ConstraintViolationException')) {
      print('L\'email existe déjà');
    }
  } else {
    print(Exception);
    throw Exception('Failed to load');
  }
}

//fonction qui créé une réservation
Future<Place> createReservation(Place place) async {
  final http.Response response = await http.post(
    apiSaveReservation,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'serviceType': place.serviceType,
      'computerNumber': place.computerNumber,
      'dateReservation': place.dateReservation,
      'timeReservation': place.timeReservation,
      'userEmail': place.userEmail,
      'access': place.access,
    }),
  );
  print(apiSaveReservation);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Place.fromJson(json.decode(response.body));
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    print(Exception);
    throw Exception('Failed to load');
  }
}

//fonction qui change l'accès d'une réservation
Future<Place> changeAccess(Place place) async {
  final http.Response response = await http.put(
    apiSaveReservation + '/' + place.id.toString(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'serviceType': place.serviceType,
      'computerNumber': place.computerNumber,
      'dateReservation': place.dateReservation,
      'timeReservation': place.timeReservation,
      'userEmail': place.userEmail,
      'access': place.access,
      'presence': place.presence,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Place.fromJson(json.decode(response.body));
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    print(Exception);
    throw Exception('Failed to load');
  }
}

//fonction qui teste si l'email appartient déjà à un utilisateur
Future<bool> testEmail(String email) async {
  final response = await http.get(apiService);
  var dio = new Dio();
  final response1 = await dio.get(apiTestEmail + '?email=' + email);

  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response1.data.length > 0)
      return true;
    else
      return false;
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

bool check = false;
Inscription userConnected = new Inscription();

//fonction qui vérifie si les identifiants de connexion sont corrects
Future<Inscription> isValidUser(
    String email, String password, BuildContext context) async {
  _sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.get(apiConnexion +
      '?email=' +
      email +
      '&password=' +
      password +
      '?number=' +
      email +
      '&password2=' +
      password);
  var dio = new Dio();
  final response1 = await dio.get(apiConnexion +
      '?email=' +
      email +
      '&password=' +
      password +
      '&number=' +
      email +
      '&password2=' +
      password);
  print('ds' + response1.data.toString());
  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response1.data.isNotEmpty) {
      userConnected.id = response1.data[0]['id'];
      userConnected.firstName = response1.data[0]['firstName'];
      userConnected.lastName = response1.data[0]['lastName'];
      userConnected.phoneNumber = response1.data[0]['phoneNumber'];
      userConnected.phoneNumber = response1.data[0]['identity'];
      userConnected.email = response1.data[0]['email'];
      userConnected.password = response1.data[0]['password'];
      userConnected.comments = response1.data[0]['comments'];
      userConnected.userType = response1.data[0]['userType'];
      //    List responseJson = json.decode(response.body);
      //userConnected = Inscription.fromJson(json.decode(response1.data));
      _sharedPreferences.setString("user", response1.data[0].toString());
      _sharedPreferences.setString(
          "email", response1.data[0]['email'].toString());
      _sharedPreferences.setString(
          "userType", response1.data[0]['userType'].toString());
      check = true;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginLoading()));
      return userConnected;
    } else {
      _sharedPreferences.setString("user", null.toString());
      print(response1.data);
      check = false;
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

//fonction qui vérifie si une réservation existe déjà
Future<String> checkExistReservation(
    String date, String time, String machine) async {
  final response = await http.get(apiReservationByCoord +
      '?date=' +
      date +
      '&time=' +
      time +
      '&machine=' +
      machine);
  var dio = new Dio();
  print('hum' + response.body);
  responseBody = response.body;
  return response.body;
}

List<Place> places = new List<Place>();

//fonction qui retourne la liste des réservation en cours d'un utilisateur
Future<List<Place>> getReservation(String email) async {
  places.clear();
  final response = await http.get(apiReservationByEmail + '?email=' + email);
  var dio = new Dio();
  final response1 = await dio.get(apiReservationByEmail + '?email=' + email);

  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for (var i = 0; i < response1.data.length; i++) {
      Place place = new Place(
        id: response1.data[i]['id'],
        serviceType: response1.data[i]['serviceType'],
        computerNumber: response1.data[i]['computerNumber'],
        dateReservation: response1.data[i]['dateReservation'],
        timeReservation: response1.data[i]['timeReservation'],
        userEmail: response1.data[i]['userEmail'],
        access: response1.data[i]['access'],
      );
      _listService.add(response1.data[i]['libelle']);
      places.add(place);
    }

    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Place.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
