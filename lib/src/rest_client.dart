import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

import 'version.dart';

class MPRestClient {
  final String BASE_URL = 'api.mercadopago.com';
  final String MIME_JSON = 'application/json';
  final String MIME_FORM = 'application/x-www-form-urlencoded';

  MPRestClient();

  String get _makeAgent => 'MercadoPago Dart SDK v${SDK_VERSION}';

  Map<String, String> get _defaultHeader {
    return {
      'User-Agent': this._makeAgent,
      'Accept': this.MIME_JSON,
    };
  }

  Uri _makeURL(String uri, [Map<String, String>? params]) {
    return Uri.https(this.BASE_URL, uri, params);
  }

  Map<String, String> _makeHeaders({
    Map<String, String>? extraHeaders,
  }) {
    if (extraHeaders != null) return this._defaultHeader..addAll(extraHeaders);
    return this._defaultHeader;
  }

  Future<Map<String, dynamic>> get(String uri,
      [Map<String, String>? params, Map<String, String>? extraHeaders]) async {
    final response = await http.get(this._makeURL(uri, params),
        headers: this._makeHeaders(extraHeaders: extraHeaders));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> post(String uri,
      {Map<String, dynamic> data = const {},
      Map<String, String>? params,
      String? contentType,
      Map<String, String>? extraHeaders}) async {
    if (extraHeaders != null) {
      extraHeaders['Content-type'] = contentType ?? this.MIME_JSON;
    } else {
      extraHeaders = {'Content-type': contentType ?? this.MIME_JSON};
    }
    final response = await http.post(this._makeURL(uri, params),
        headers: this._makeHeaders(extraHeaders: extraHeaders),
        body: json.encode(data));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> put(String uri,
      {Map<String, dynamic> data = const {},
      Map<String, String>? params,
      String? contentType,
      Map<String, String>? extraHeaders}) async {
    if (extraHeaders != null) {
      extraHeaders['Content-type'] = contentType ?? this.MIME_JSON;
    } else {
      extraHeaders = {'Content-type': contentType ?? this.MIME_JSON};
    }

    final response = await http.put(this._makeURL(uri, params),
        headers: this._makeHeaders(extraHeaders: extraHeaders),
        body: json.encode(data));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }

  Future<Map<String, dynamic>> delete(String uri,
      {Map<String, String> params = const {},
      Map<String, String>? extraHeaders}) async {
    final response = await http.delete(this._makeURL(uri, params),
        headers: this._makeHeaders(extraHeaders: extraHeaders));

    return {
      'status': response.statusCode,
      'response': json.decode(response.body),
    };
  }
}
