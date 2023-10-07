import 'dart:developer';
import 'package:recordam/utils/utils.dart';

class NetworkService {
  static final Dio _dio = Dio();

  Future<Response> getRequestHandler(
    String path, {
    Options? options,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryPatameters,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    String uri = '${AppConstant.baseUrl}/api/$path';
    if (!useBaseUrl) {
      uri = path;
    }
    final a = await _dio.get(
      uri,
      options: options,
      queryParameters: queryPatameters,
      data: data,
      cancelToken: cancelToken,
    );
    log(a.data.toString());
    return a;
  }

  Future<Response> postRequestHandler(
    String path, {
    Object? data,
    Options? options,
    bool? deviceToken,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    Uri uri = Uri.parse('${AppConstant.baseUrl}/api/$path');
    if (!useBaseUrl) {
      uri = Uri.parse(path);
    }
    final a = await _dio.postUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
    log(a.data.toString());
    return a;
  }

  Future<Response> patchRequestHandler(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
    bool useBaseUrl = true,
    CancelToken? cancelToken,
  }) async {
    Uri uri = Uri.parse('${AppConstant.baseUrl}/api/$path');
    if (!useBaseUrl) {
      uri = Uri.parse(path);
    }
    final a = await _dio.patchUri(
      uri,
      cancelToken: cancelToken,
      data: data,
      options: options,
    );
    log(a.data.toString());
    return a;
  }
}
