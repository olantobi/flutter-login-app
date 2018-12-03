
import 'package:flutter/material.dart';

import 'package:testapp/view/login_screen.dart';
import 'package:testapp/view/home_screen.dart';

final routes = {
  '/login':   (BuildContext context) => LoginScreen(),
  '/home':    (BuildContext context) => HomeScreen(),
  '/':        (BuildContext context) => LoginScreen()
};