import 'package:balloons/src/utils/colors.dart';
import 'package:flutter/material.dart';

class Styles {
//  Text appText(String message,{ double size, Color color, FontWeight fontWeight}){
//    return Text(
//      message,
//      style: TextStyle(
//        fontSize: 16.0,
//        fontWeight: fontWeight?
//      ),
//    );
//  }

  InputDecoration textDecoration(String labelText, IconData icon) {
    return InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ));
  }

  TextStyle textProperty(double fontSize, Color fontColor) {
    return TextStyle(fontSize: fontSize, color: fontColor);
  }

  RoundedRectangleBorder buttonRounded(double radius, Color borderColor) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor));
  }


  InputDecoration textField(String labelText){
    return InputDecoration(
      labelText: labelText,
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
    );
  }


  Widget dotDark() {
    return Container(
      width: 60,
      height: 60,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.deepOrange),
    );
  }

  Widget dotFade(){
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.deepOrange.shade200),
    );
  }

  BoxDecoration tagBorder(){
    return BoxDecoration(
        border: Border.all(
          color: AppColor.colorPrimaryDark,
          width: 4
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
    );
  }
}
