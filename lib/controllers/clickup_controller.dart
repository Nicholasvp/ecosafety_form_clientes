import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClickupController {
  final _dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': dotenv.env['CLICKUP_API_KEY'] ?? '',
        'accept': 'application/json',
      },
    ),
  );

  final _urlClientes = 'https://api.clickup.com/api/v2/list/901303114710/task';
  final _urlCustomFields =
      'https://api.clickup.com/api/v2/list/901303114710/field';

  Future<Response> createTask({
    required String name,
    required String description,
  }) async {
    final data = {'name': name, 'description': description};

    try {
      final response = await _dio.post(_urlClientes, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTasks({int limit = 20}) async {
    try {
      final response = await _dio.get(
        _urlClientes,
        queryParameters: {'limit': limit},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
