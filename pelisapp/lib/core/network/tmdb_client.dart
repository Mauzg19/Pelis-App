import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/tmdb_constants.dart';

class TmdbClient {
  static final http.Client _client = http.Client();

  static Future<http.Response> get(String path,
      {Map<String, String>? queryParameters}) async {
    final uri = Uri.parse('${TmdbConstants.baseUrl}$path').replace(
      queryParameters: {
        'api_key': TmdbConstants.apiKey,
        'language': TmdbConstants.language,
        ...?queryParameters,
      },
    );

    final response = await _client.get(uri, headers: {
      'Authorization': 'Bearer ${TmdbConstants.readAccessToken}',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    throw TmdbException(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['status_message'] ??
          'Error en la petición a TMDB',
    );
  }
}

class TmdbException implements Exception {
  const TmdbException({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  String toString() => 'TmdbException(statusCode: $statusCode, message: $message)';
}
