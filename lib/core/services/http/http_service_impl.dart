import 'package:dio/dio.dart';
import 'package:mycustomers/core/exceptions/network_exception.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/core/utils/network_utils.dart' as network_utils;


import 'http_service.dart';

/// Helper service that abstracts away common HTTP Requests
class HttpServiceImpl implements HttpService {

  final _dio = Dio();

  setHeader(Map<String, dynamic> header) {
    _dio.options.headers.addAll(header);
  }

  @override
  Future<dynamic> getHttp(String route, {Map<String, dynamic> params}) async {
    Response response;

    Logger.d('[GET] Sending $params to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.get(
        fullRoute,
        queryParameters: params,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      Logger.e('HttpService: Failed to GET $route: Error message: ${e.message}');
      print('Http response data is: ${e.response.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, dynamic body, {Map<String, dynamic> params}) async {
    Response response;

    Logger.d('[POST] Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.post(
        fullRoute,
        data: body,
        queryParameters: params,
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      Logger.e('HttpService: Failed to POST ${e.message}');
      print('Http response data is: ${e.response.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  void dispose() {
    _dio.clear();
    _dio.close(force: true);
  }

  @override
  clearHeaders() {
    _dio.options.headers.clear();
  }

  @override
  Future putHttp(String route, body, {Map<String, dynamic> params}) async {
    Response response;

    Logger.d('[PUT] Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.put(
        fullRoute,
        data: body,
        queryParameters: params,
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      Logger.e('HttpService: Failed to PUT ${e.message}');
      print('Http response data is: ${e.response.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future deleteHttp(String route, {Map<String, dynamic> params}) async {
    Response response;

    Logger.d('[DELETE] Sending $params to $route');

    try {
      final fullRoute = '$route';
      response = await _dio.delete(
        fullRoute,
        queryParameters: params,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioError catch (e) {
      Logger.e('HttpService: Failed to DELETE $route: Error message: ${e.message}');
      print('Http response data is: ${e.response.data}');
      throw NetworkException(e.response?.data != null ? e.response.data['message'] ?? e.message : e.message);
    }

    network_utils.checkForNetworkExceptions(response);

    Logger.d('Received Response: $response');

    // For this specific API its decodes json for us
    return response.data;
  }
}
