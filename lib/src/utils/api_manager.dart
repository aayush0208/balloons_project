
import 'package:http/http.dart' show Client, Response;

class APIManager{

  static final APIManager _apiManager = APIManager._internal();

  factory APIManager(){
    return _apiManager;
  }
  APIManager._internal();

  Future<Response> post(String url, var body)async{
    final client = Client();
    try{
      var response = await client.post(url,body: body);

      return response;
    }catch(e){
      print(e);
      return null;
    } finally{
      client.close();
    }
  }

  Future<dynamic> postWithHeader(String url, var body, var header)async{
    final client = Client();
    try{
      var response = await client.post(url,body: body, headers: header);
      return response;
    }catch(e){
      print(e);
      return null;
    } finally{
      client.close();
    }
  }
}