import 'dart:convert';

import 'package:balloons/src/screens/home.dart';
import 'package:balloons/src/utils/Strings.dart';
import 'package:balloons/src/utils/api_manager.dart';
import 'package:balloons/src/utils/colors.dart';
import 'package:balloons/src/utils/helper.dart';
import 'package:balloons/src/utils/styles.dart';
import 'package:balloons/src/utils/urls.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email;
  TextEditingController _password;
  Styles _styles;
  Helper _helper;
  bool _hidePass = true;

  final _scaffoldKey = GlobalKey<ScaffoldState> ();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _email =  new TextEditingController();
    _password = new TextEditingController();
    _styles = new Styles();
    _helper = new Helper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(child: mainLayout()),
    );
  }

  Widget mainLayout(){
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Container(margin: EdgeInsets.only(left: 40),width: double.infinity,child: Container(alignment: Alignment.centerLeft,child: Text(Strings.login, style: TextStyle(fontSize: 25, color: AppColor.black),))),
            SizedBox(height: 20,),
            _layoutEmail(),
            SizedBox(height: 30,),
            _layoutPassword(),
            SizedBox(height: 50,),
            _signUpButton()
          ],
        ),
      ),
    );
  }

  Widget _layoutEmail(){
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: _styles.textField(Strings.emailAddress),
        controller: _email,
        keyboardType: TextInputType.text,
        validator: (value){
          if(value.isEmpty) return "Please enter email";
          if(!_helper.isEmail(value)) return "Invalid email";
          return null;
        },
      ),
    );
  }

  Widget _layoutPassword(){
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        obscureText: true,
        decoration: _styles.textField(Strings.passwordText),
        controller: _password,
        keyboardType: TextInputType.text,
        validator: (value){
          if(value.isEmpty) return "Please enter password";
          if(value.length<6) return "Password is too short";
          return null;
        },
      ),
    );
  }

  Widget _signUpButton(){
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: 45,
      child: RaisedButton(onPressed: (){},
        child: Text(Strings.loginText, style: _styles.textProperty(16.0, Colors.white),),
        shape: _styles.buttonRounded(18.0, AppColor.colorPrimaryDark),
        color: AppColor.colorPrimaryDark,
      ),
    );
  }

  void doLogin()async{
    if(!_formKey.currentState.validate()) return;

    _scaffoldKey.currentState.showSnackBar(_helper.showSnackbar(Strings.authenticating));
    APIManager apiManager = new APIManager();

    var body = {
      Strings.email = _email.text.toString(),
      Strings.password = _password.text.toString()
    };
     var response  = await apiManager.post(Urls.LOGIN, body);

     _scaffoldKey.currentState.hideCurrentSnackBar();

     print(response.statusCode);
     var data = json.decode(response.body);
    _helper.saveToSharedPrefrences(Strings.token, data[Strings.token].toString());

    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> HomeScreen()));
  }
}
