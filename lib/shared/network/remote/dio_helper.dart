import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
  static Dio dio;

  static getInstance()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/',//'http://api.mediastack.com/v1/',

          receiveDataWhenStatusError: true
        )
    );
  }

 static Future<Response> getDate({
    @required String path,
    @required Map<String,dynamic> condition,
})async
  {
    return await dio.get(path, queryParameters: condition);
  }
}