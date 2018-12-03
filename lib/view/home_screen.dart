
import 'package:flutter/material.dart';
import 'package:testapp/model/user.dart';
import 'package:testapp/view/home_screen_presenter.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {    
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> implements HomeScreenContract {
  HomeScreenPresenter _presenter;
  String _homeText = "";

  HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
    _presenter.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: new AppBar(
        title: Text("Home"),      
      ),
      body: Center(
        child: Text(_homeText),
      ),
    );
  }

  @override
  void onDisplayUserInfo(User user) {
    setState(() {
      _homeText = 'Hello ${user.username}';
    });
  }

  @override
  void onErrorUserInfo() {
    setState(() {
      _homeText = 'There was an error retrieving user info';
    });
  }

}