import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:ondigit/constante.dart';
import 'package:ondigit/models/service.dart';

List<Service> _services = new List<Service>();
const List<String> _listService = [];
Future<List<String>> fetchService() async {
  final response = await http.get(apiService);
  var dio = new Dio();
  final response1 = await dio.get(apiService);

  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for( var i = 0 ; i <response1.data.length; i++ ) {
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