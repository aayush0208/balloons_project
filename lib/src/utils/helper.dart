import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper{

   bool isEmail(String email) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  BoxDecoration boxDecoration(){
     return new BoxDecoration(
       shape: BoxShape.rectangle,
       border: new Border.all(
         color: Colors.grey,
       ),
       borderRadius: BorderRadius.all(Radius.circular(15))
     );
   }

    void showToast(var message, { var length}){
     Fluttertoast.showToast(msg: message.toString(), toastLength:Toast.LENGTH_SHORT );
   }

   saveToSharedPrefrences(String key, dynamic value)async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString(key, value);
   }

   Future<DateTime> agePicker (BuildContext context,{var pastdate}) async {
     final DateTime picked = await showDatePicker(
         context: context,
         initialDate: DateTime(2000),
         firstDate: DateTime(1970),
         lastDate: DateTime(2010));

     return picked;
   }

   Widget showSnackbar(String message){
     return SnackBar(
       content: Text(message),

     );
   }
}