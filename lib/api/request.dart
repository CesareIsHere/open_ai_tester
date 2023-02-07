import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:open_ai_tester/models/openai_variables_model.dart';

Future<Response> handleGet(
    {required String url, Map<String, dynamic>? query}) async {
  // Instancing the dio client
  var dio = Dio();

  var token = GetIt.I.get<OpenAiVariablesModel>().token;

  // Removing null values from the query parameters.
  query?.removeWhere((key, value) => value == null);

  Response response;

  try {
    response = await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  } catch (e) {
    rethrow;
  }

  return response;
}

Future<Response> handlePost(
    {required String url, Map<dynamic, dynamic>? payload}) async {
  // Instancing the dio client
  var dio = Dio();

  var token = GetIt.I.get<OpenAiVariablesModel>().token;

  Response response;

  try {
    response = await dio.post(
      url,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode(payload),
    );
  } catch (e) {
    rethrow;
  }

  return response;
}

Future<Response> handlePut(
    {required String url, Map<dynamic, dynamic>? payload}) async {
  // Instancing the dio client
  var dio = Dio();

  var token = GetIt.I.get<OpenAiVariablesModel>().token;

  Response response;

  try {
    response = await dio.put(
      url,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ),
      data: payload,
    );
  } on DioError catch (e) {
    response = e.response!;
  }

  return response;
}

Future<Response> handlePatch(
    {required String url, Map<dynamic, dynamic>? payload}) async {
  // Instancing the dio client
  var dio = Dio();

  var token = GetIt.I.get<OpenAiVariablesModel>().token;

  Response response;

  try {
    response = await dio.patch(
      url,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ),
      data: payload,
    );
  } catch (e) {
    rethrow;
  }

  return response;
}

Future<Response> handleDelete(
    {required String url, Map<dynamic, dynamic>? payload}) async {
  // Instancing the dio client
  var dio = Dio();

  var token = GetIt.I.get<OpenAiVariablesModel>().token;

  Response response;

  try {
    response = await dio.delete(
      url,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ),
      data: payload,
    );
  } on DioError catch (e) {
    response = e.response!;
  }

  return response;
}
