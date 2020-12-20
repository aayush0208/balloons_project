import 'dart:convert';

import 'package:balloons/src/screens/profile_images.dart';
import 'package:balloons/src/utils/Strings.dart';
import 'package:balloons/src/utils/api_manager.dart';
import 'package:balloons/src/utils/colors.dart';
import 'package:balloons/src/utils/helper.dart';
import 'package:balloons/src/utils/styles.dart';
import 'package:balloons/src/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email, _password, _name, _dob;
  String _date;
  Styles _styles;
  Helper _helper;
  final _formKey = GlobalKey<FormState>();
  var _gender = "Male";

  @override
  void initState() {
    _email = new TextEditingController();
    _password = new TextEditingController();
    _name = new TextEditingController();
    _dob = new TextEditingController();
    _styles = new Styles();
    _helper = new Helper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: mainLayout()),
    );
  }

  Widget mainLayout() {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(margin: EdgeInsets.only(left: 40),width: double.infinity,child: Container(alignment: Alignment.centerLeft,child: Text(Strings.newAccount, style: TextStyle(fontSize: 25, color: AppColor.black),))),
              SizedBox(height: 20,),
              _layoutName(),
              SizedBox(
                height: 20,
              ),
              _layoutDOB(),
              SizedBox(height: 20,),

              _userGender(),

              SizedBox(
                height: 20,
              ),
              _layoutEmail(),
              SizedBox(
                height: 20,
              ),
              _layoutPassword(),
              SizedBox(
                height: 40,
              ),
              _signUpButton()
            ],
          ),
        ],
      ),
    ));
  }

  Widget _layoutEmail() {
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

  Widget _layoutName() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        decoration: _styles.textField(Strings.nameTxt),
        controller: _name,
        keyboardType: TextInputType.text,
        validator: (value){
          if(value.isEmpty) return "Please enter name";
          return null;
        },
      ),
    );
  }

  Widget _layoutDOB() {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());

          _helper.agePicker(context).then((date) {
            setState(() {
              _date = date.toIso8601String();
              date == null
                  ? _dob.text = ""
                  : _dob.text = new DateFormat('dd-MM-yyyy').format(date);
            });
          });
        },
        decoration: _styles.textField(Strings.dobTxt),
        controller: _dob,
        keyboardType: TextInputType.text,
        validator: (value){
          if(value.isEmpty) return "Please enter Date of Birth";
          return null;
        },
      ),
    );
  }

  Widget _layoutPassword() {
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

  Widget _userGender(){
   return  Container(
     margin: EdgeInsets.only(left: 40, right: 40),
      decoration: _helper.boxDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _gender,
          hint: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text('Gender',),
          ),
          items: <String>['Male', 'Female', 'Other'].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child:  Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String value) {
            setState((){
              _gender = value;
            });
          },
        ),
      )
    );
  }

  Widget _signUpButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      margin: EdgeInsets.only(bottom: 40),
      child: RaisedButton(
        onPressed: () {
          _navigate();
        },
        child: Text(
          Strings.continueText,
          style: _styles.textProperty(16.0, Colors.white),
        ),
        shape: _styles.buttonRounded(18.0, AppColor.colorPrimaryDark),
        color: AppColor.colorPrimaryDark,
      ),
    );
  }

  _navigate() async {

    if(!_formKey.currentState.validate()) return;

    Map body = {
      Strings.name: _name.text.toString(),
      Strings.dob: _date,
      Strings.gender : _gender.toString(),
      Strings.email: _email.text.toString(),
      Strings.password : _password.text.toString(),
      Strings.preference : "Dating",
    };

    print(body);

    APIManager apiManager = new APIManager();
    print(Urls.SIGNUP);
    var response = await apiManager.post(Urls.SIGNUP, body,);

    var data = json.decode(response.body);
    print(data);
    print(response.statusCode);

    if(response.statusCode == Strings.UNAUTHORIZED ){
      Fluttertoast.showToast(msg: data['msg'], toastLength: Toast.LENGTH_SHORT);
      return;
    }

    if(response.statusCode == Strings.INTERNAL_SERVER_ERROR){
      Fluttertoast.showToast(msg: Strings.INTERNAL_SERVER_ERROR_MESSAGE, toastLength: Toast.LENGTH_SHORT);
      return;
    }

    _helper.saveToSharedPrefrences(Strings.token, data[Strings.token].toString());
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => ProfileImage()));
  }
}
