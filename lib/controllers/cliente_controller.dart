import 'package:ecosafety_form_clientes/controllers/clickup_controller.dart';
import 'package:flutter/material.dart';

class ClienteController {
  final ClickupController clickupController = ClickupController();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  Future<void> createClientTask({
    required String name,
    required String email,
    required String telefone,
  }) async {
    try {
      final description = 'Cliente: $name\nEmail: $email\nTelefone: $telefone';
      final response = await clickupController.createTask(
        name: name,
        description: description,
      );
      print('Task created successfully: ${response.data}');
    } catch (e) {
      print('Error creating task: $e');
    }
  }

  Future<void> getClientes({int limit = 20}) async {
    try {
      final response = await clickupController.getTasks(limit: limit);
      print('Tasks retrieved successfully: ${response.data}');
    } catch (e) {
      print('Error retrieving tasks: $e');
    }
  }
}
