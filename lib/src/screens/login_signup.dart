import 'package:balloons/src/screens/signup.dart';
import 'package:balloons/src/utils/Strings.dart';
import 'package:balloons/src/utils/colors.dart';
import 'package:balloons/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  BuildContext _context;
  Styles _styles;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._styles = new Styles();
  }
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
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/images/ballonlogo.svg',height: 70,),
              ),
            ),
            Expanded(child:
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _signUpButton(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _loginButton(),
                ),

              ],
            ))
          ],
        )
    );
  }

  Widget _loginButton(){
    return Container(margin: EdgeInsets.only(bottom: 60, top: 20),
      width: 120,
      height: 40,
      child: RaisedButton(
        onPressed: ()=>Navigator.of(_context).push(new MaterialPageRoute(builder: (context)=> Login())),
        color: AppColor.colorPrimary,
        shape: _styles.buttonRounded(20.0, AppColor.colorPrimary),
        child: Text(Strings.loginText, style: TextStyle(color: AppColor.white),),
      ),
    );
  }

  Widget _signUpButton(){
    return Container(
      width: 180,
      height: 40,
      child: RaisedButton(onPressed: ()=> Navigator.of(_context).push(new MaterialPageRoute(builder: (context)=>SignUp())),
        shape: _styles.buttonRounded(20.0, AppColor.colorPrimaryDark),
        color: AppColor.colorPrimaryDark,
        child: Text(Strings.signUpText, style: TextStyle(color: AppColor.white),),),
    );
  }
}
