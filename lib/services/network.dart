import 'package:recordam/utils/utils.dart';

abstract class NetworkService {
  final Dio _dio = Dio();

  NetworkService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          var token = LocalStorage.instance.getToken();
          if (token != null) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Logout
            routes.routerDelegate.navigatorKey.currentContext!.goNamed(
              LoginScreen.name,
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

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
    debugPrint(a.data.toString());
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
    debugPrint(a.data.toString());
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
    debugPrint(a.data.toString());
    return a;
  }
}
