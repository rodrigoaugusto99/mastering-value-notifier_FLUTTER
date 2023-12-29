import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';
import 'package:uno/uno.dart';

class DioHttpService extends IHttpService {
  final uno = Uno();
  @override
  Future delete(String url, {data}) {
    return uno.delete(url, data: data);
  }

  @override
  Future get(String url) {
    return uno.get(url);
  }

  @override
  Future patch(String url, {data}) {
    return uno.patch(url, data: data);
  }

  @override
  Future post(String url, {data}) {
    return uno.post(url, data: data);
  }

  @override
  Future put(String url, {data}) {
    return uno.put(url, data: data);
  }
}
