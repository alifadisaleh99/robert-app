import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../styles/color.dart';
import '../../styles/image_assets.dart';
import '../local/cache_helper.dart';
import 'base_url.dart';

class DioHelper {
  static late Dio dio;

  static init({
    String? authorizationHeader,
    String? contentTypeHeader,
  }) {
    print("${Config.baseURL}/");
    dio = Dio(
      BaseOptions(
        baseUrl: "${Config.baseURL}/",
      ),
    );
    dio.options.headers = {
      if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Accept-Language': '${CacheHelper.getData(key: 'locale')}',
      'Content-Type': 'multipart/form-data',

      // 'Content-Type': 'application/json',
      // 'Accept-Language':
      // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
    };

    dio.interceptors.add(
      LogInterceptor(
      )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    final headers = {
      // 'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImlhdCI6MTcxOTE2OTc5MX0.2kVIbvOF17cmZm-kVRjYSNycpBJ2CUuRS1ExqMuo7bw",

      if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

      // 'Accept-Language':
      // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
    };
    print(url);
    print(headers);

    return await dio.get(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers,),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    print('POST Request - URL: $url');
    print('POST Request - Headers: $headers');
    print('POST Request - data:$data');

    final options = Options(
      headers: {
        if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
        'Content-Type': 'application/json',
        'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

        // 'Accept-Language': '${CacheHelper.getData(key: 'locale')}',
      },
    );
    final response = await dio.post(
      url,
      data: data,
      options: options,
    );
    return response;
  }

  static Future<Response> postDataWithOutData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    print('POST Request - URL: $url');
    print('POST Request - data: $data');

    // Wrap data in FormData to send it as form data
    final formData = data != null ? FormData.fromMap(data) : null;
    print('POST Request - formData: $formData');

    final options = Options(
      headers: {
        if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
        'Content-Type': 'application/json',
        'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

        // 'Accept-Language':
        // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
      },
    );

    final response = await Dio().post(
      url,
      data: formData,
      options: options,
    );

    return response;
  }


  static Future<Response> postDataWithContentType({
    required String url,
    // Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    print('POST Request - URL: $url');
    // print('POST Request - data: $data');

    // Wrap data in FormData to send it as form data
    // final formData = data != null ? FormData.fromMap(data) : null;
    // print('POST Request - formData: $formData');

    final options = Options(
      headers: {
        if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
        'Content-Type':'multipart/form-data',
        'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

        // 'Accept-Language':
        // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
      },
    );

    final response = await Dio().post(
      url,
      // data: formData,
      options: options,
    );

    return response;
  }

  static Future<Response> postDataWithFormData({
    required String url,
    required FormData formData,
  }) async {
    print('POST Request - URL: $url');
    final options = Options(headers: {
      if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

      // 'Accept-Language':
      // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
    });
    print(options);
    final response = await dio.post(
      url,
      data: formData,
      options: options,
    );
    return response;
  }
  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> postDataMulti({
    required String url,
    required dynamic data,
  }) async {
    final options = Options(headers: {
      if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      'Accept-Language': '${CacheHelper.getData(key: 'locale')}',

      // 'Accept-Language':
      // '${CacheHelper.getData(key: 'locale') == "fa" ? "ku" : CacheHelper.getData(key: 'locale')}',
    });
    final response = await dio.post(
      url,
      data: data,
      options: options,
    );
    return response;
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    final options = Options(headers: {
      if(CacheHelper.getData(key: 'token')!=null)'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      'Accept-Language': '${CacheHelper.getData(key: 'locale')}',
    });
    final response = await dio.delete(
      url,
      data: data,
      options: options,
    );
    return response;
  }
}
