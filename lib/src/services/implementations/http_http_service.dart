import 'package:flutter_value_notifier_flutterando/src/services/http_service.dart';
import 'package:http/http.dart' as http;

class HttpHttpService extends IHttpService {
  //final url = Uri.parse('http://127.0.0.1:3031/products');

  @override
  Future delete(String url, {data}) {
    return http.delete(Uri.parse(url), body: data);
  }

  @override
  Future get(String url) {
    return http.get(Uri.parse(url));
  }

  @override
  Future patch(String url, {data}) {
    return http.patch(Uri.parse(url), body: data);
  }

  @override
  Future post(String url, {data}) {
    return http.post(Uri.parse(url), body: data);
  }

  @override
  Future put(String url, {data}) {
    return http.put(Uri.parse(url), body: data);
  }
}
