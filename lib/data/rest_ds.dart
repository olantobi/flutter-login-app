
import 'dart:async';

import 'package:testapp/utils/network_utils.dart';
import 'package:testapp/model/user.dart';


class RestDatasource {
    NetworkUtils _networkUtils = new NetworkUtils();
    static final BASE_URL = "http://www.mocky.io/v2/5c04843f3300005f00d01d39?mocky-delay=5s";

    Future<User> login(String username, String password) {
      return _networkUtils.post(BASE_URL, body : {
        "username": username,
        "password": password
      }).then((dynamic res) {
        print("Response from network...");
        print(res.toString());
        return User(username, password);
      });
    }
}