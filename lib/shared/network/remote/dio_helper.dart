import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org",
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData(
    {
      required String url,
      @required Map<String , dynamic>?query

    }
  )async
  {

    return await dio!.get(url,queryParameters: query );
  }


}


//https://newsapi.org ----->Base URL
//     /v2/top-headlines -----> Method
//?country=eg&apiKey=443836f0e19e4cffb9dbef9291d0a438 ---->Query