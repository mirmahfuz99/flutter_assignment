import 'package:dio/dio.dart';

class Options {
  static const BASE_API_URL = " http://apptest.dokandemo.com/wp-json";
  static Map<String, String> headersMap = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  static Map<String, String> headersMapTwo = {
    'Content-Type': 'application/json',
  };
}

class ApiService{
  ///User Registration
  static userSignUp(Map<String, dynamic> data) async {
    Dio dio = new Dio();
    dio.options.headers = Options.headersMapTwo;
    FormData formData = new FormData.fromMap(data); //retrive data json format from Map value
    var response = await dio
        .post(
      "${Options.BASE_API_URL}/wp/v2/users/register",
      data: formData,
    )
        .catchError((e) {
//      print("Response: " + e.response?.statusCode.toString());
//      print("Response: " + e.messages);
      return null;
    });
    return response;
  }
  ///User SignUp
  static userLogin( String username, String password) async {
    Dio dio = new Dio();
    dio.options.headers = Options.headersMap;
    var response = await dio
        .post(
      "${Options.BASE_API_URL}/jwt-auth/v1/token?username=$username&password=$password",
    )
        .catchError((e) {
      print("Response: " + e.response?.statusCode.toString());
      print("Response: " + e.messages);
      return null;
    });
    return response;
  }

}