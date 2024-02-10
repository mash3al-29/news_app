import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
       baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> GetData(
      @required String url,
      @required Map<String,dynamic> queries,
      )async {
    return await dio.get
      (
        url,
        queryParameters: queries,
      );
  }
}