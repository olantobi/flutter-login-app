
import 'package:flutter/material.dart';

import 'package:testapp/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App with Login',
      theme: ThemeData(        
        primarySwatch: Colors.red,
      ),      
      routes: routes,
    );
  }
}