
import 'dart:async';    // to run async operations
import 'dart:convert';  // to convert data

import 'package:http/http.dart' as http;  // to make http requests

class NetworkUtils {

  // next three lines makes this class a singleton
  static NetworkUtils _instance = new NetworkUtils.internal();
  NetworkUtils.internal();
  factory NetworkUtils() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {      
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      return _decoder.convert(res);
    }).catchError((Exception error) => print("Error: "+error.toString()));
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {            
            final String res = response.body;
            final int statusCode = response.statusCode;

            if (statusCode < 200 || statusCode >= 400 || json == null) {
                throw new Exception("Error while fetching data");
            }

            return _decoder.convert(res);
        }).catchError((Exception error) => print("Error: "+error.toString()));
  }
}