import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final String endPoint;
  NetworkService({@required this.endPoint});

  Future<String> retrieveCall() async {
    http.Response response = await http.get(endPoint); // change

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (response.statusCode);
    }
  }
}
