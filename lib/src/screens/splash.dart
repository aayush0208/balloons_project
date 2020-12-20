
import 'package:balloons/src/screens/signup.dart';
import 'package:balloons/src/utils/Strings.dart';
import 'package:balloons/src/utils/localizations.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatelessWidget {

  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      body: mainLayout(),
    );
  }

  Widget mainLayout(){
    return SafeArea(child:
    Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: _loginButton(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _signUpButton(),
        )
      ],
    )
    );
  }
  
  Widget _loginButton(){
    return RaisedButton(onPressed: ()=>Navigator.of(_context).push(new MaterialPageRoute(builder: (context)=> Login())),
    child: Text(Strings.loginText),
    );
  }

  Widget _signUpButton(){
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: RaisedButton(onPressed: ()=> Navigator.of(_context).push(new MaterialPageRoute(builder: (context)=>SignUp())),
      child: Text(Strings.signUpText),),
    );
  }
}
