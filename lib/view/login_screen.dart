
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:testapp/view/login_screen_presenter.dart';
import 'package:testapp/auth_state_provider.dart';
import 'package:testapp/model/user.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {    
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> implements LoginScreenContract, AuthStateListener {

  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();

      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {        
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));           
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state ==  AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: Text('Login'),
      color: Colors.primaries[0],
    );

    var loginForm = Column(
      children: <Widget>[
        Text(
          "",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10 ? "Invalid username/password" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                    labelText: "Password"
                  ),
                ),
              )
            ],
          ),
        ),                
        _isLoading ? CircularProgressIndicator() : loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return Scaffold(      
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  child: loginForm,
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)
                    )
                  ),
                ),
              ),
          ),
        ),
      );        
  }

  @override
  void onLoginError(String errorTxt) {
    //_showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async {
    //_showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var authStateProvider = AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  } 
}

