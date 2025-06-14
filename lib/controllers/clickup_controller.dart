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

  /// Cria uma task no ClickUp com custom fields
  Future<Response> createTask({required String name, Map<String, dynamic>? customFields}) async {
    final data = {
      'name': name,
      if (customFields != null) 'custom_fields': customFields, // Envia os custom fields no formato correto
    };

    try {
      final response = await _dio.post(_urlClientes, data: data);
      return response;
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  /// Retorna a lista de tasks
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
