import 'package:flutter/material.dart';

class Widgets{

  static final Widgets _widgets  = Widgets._internal();


  factory Widgets() {return _widgets;}

  Widgets._internal();


   Widget button(){
     return RaisedButton(onPressed:(){} );
   }
}