import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ondigit/constante.dart';
import 'package:ondigit/loginLoad.dart';
import 'package:ondigit/models/Place.dart';
import 'package:ondigit/models/inscription.dart';
import 'package:ondigit/models/service.dart';
import 'package:ondigit/screens/inscription.dart';

List<Service> _services = new List<Service>();

List<String> _listService = new List();

Future<List<String>> fetchService() async {
  final response = await http.get(apiService);
  var dio = new Dio();
  final response1 = await dio.get(apiService);

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
    }
    return _listService;
//    List responseJson = json.decode(response.body);
//    return responseJson.map((m) => new Service.fromJson(m)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

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

Future<Place> createReservation(Place place) async {
  final http.Response response = await http.post(
    apiSaveReservation,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'serviceType': place.serviceType,
      'computerNumber': place.computerNumber,
      'dateReservation': place.dateReservation,
      'timeReservation': place.timeReservation,
      'userEmail': place.userEmail,
      'access': place.access,
    }),
  );
  print(response.body.contains('ConstraintViolationException'));
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

Future<bool> testEmail(String email) async {
  final response = await http.get(apiService);
  var dio = new Dio();
  final response1 = await dio.get(apiTestEmail + '?email=' + email);

  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response1.data.length > 0) return true;
    else return false;
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

Future<Inscription> isValidUser(
    String email, String password, BuildContext context) async {
  final response = await http
      .get(apiConnexion + '?email=' + email + '&password=' + password);
  var dio = new Dio();
  final response1 =
      await dio.get(apiConnexion + '?email=' + email + '&password=' + password);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if (response1.data.isNotEmpty) {
      print('haut');
      userConnected.id = response1.data[0]['id'];
      userConnected.firstName = response1.data[0]['firstName'];
      userConnected.lastName = response1.data[0]['lastName'];
      userConnected.phoneNumber = response1.data[0]['phoneNumber'];
      userConnected.email = response1.data[0]['email'];
      userConnected.password = response1.data[0]['password'];
      userConnected.comments = response1.data[0]['comments'];
      userConnected.userType = response1.data[0]['userType'];
      //    List responseJson = json.decode(response.body);
      //userConnected = Inscription.fromJson(json.decode(response1.data));
      check = true;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginLoading()));
      return userConnected;
    } else {
      check = false;
      return null;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }

  Inscription getUser(Inscription user) {
    return user;
  }
}
