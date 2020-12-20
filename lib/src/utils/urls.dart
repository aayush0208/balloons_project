import 'package:balloons/src/utils/Strings.dart';

class Urls {

  static final String _baseUrl = "http://18.194.225.169/api/";

  static final String SIGNUP = _baseUrl + Strings.SIGNUP;
  static final String UPLOAD_IMAGE = _baseUrl +"user/"+ Strings.IMAGE;
  static final String LOGIN = _baseUrl + Strings.LOGIN;
}