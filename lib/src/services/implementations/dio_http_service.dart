import 'package:dio/dio.dart';
import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';

class DioHttpService extends IHttpService {
  final dio = Dio();
  @override
  Future delete(String url, {data}) {
    return dio.delete(url, data: data);
  }

  @override
  Future get(String url) {
    return dio.get(url);
  }

  @override
  Future patch(String url, {data}) {
    return dio.patch(url, data: data);
  }

  @override
  Future post(String url, {data}) {
    return dio.post(url, data: data);
  }

  @override
  Future put(String url, {data}) {
    return dio.put(url, data: data);
  }
}
