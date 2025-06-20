import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClickupController {
  final _dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': dotenv.env['CLICKUP_API_KEY'] ?? '',
        'accept': 'application/json',
        'content-type': 'application/json',
      },
    ),
  );

  final _urlClientes = 'https://api.clickup.com/api/v2/list/901303114710/task';
  final _urlCustomFields = 'https://api.clickup.com/api/v2/list/901303114710/field';

  Future<Response> createTask({required String name, Map<String, dynamic>? customFields}) async {
    final data = {'name': name};

    try {
      final response = await _dio.post(_urlClientes, data: data);

      final taskId = response.data['id'];

      if (customFields != null) {
        for (final entry in customFields.entries) {
          final fieldId = entry.key;
          final value = entry.value;

          await _dio.post('https://api.clickup.com/api/v2/task/$taskId/field/$fieldId', data: {'value': value});
        }
      }

      return response;
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  Future<Response> getTasks({int limit = 20}) async {
    try {
      final response = await _dio.get(_urlClientes, queryParameters: {'limit': limit});
      return response;
    } catch (e) {
      print('Error retrieving tasks: $e');
      rethrow;
    }
  }

  /// Retorna os custom fields da lista
  Future<Response> getCustomFields() async {
    try {
      final response = await _dio.get(_urlCustomFields);
      return response;
    } catch (e) {
      print('Error retrieving custom fields: $e');
      rethrow;
    }
  }
}
