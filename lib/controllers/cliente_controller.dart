import 'package:ecosafety_form_clientes/controllers/clickup_controller.dart';
import 'package:ecosafety_form_clientes/models/clickup_custom_fields.dart';
import 'package:flutter/material.dart';

class ClienteController {
  final ClickupController clickupController = ClickupController();

  /// Lista dos custom fields
  ValueNotifier<List<ClickupCustomFields>> customFields = ValueNotifier<List<ClickupCustomFields>>([]);

  /// Controllers dos campos
  final Map<String, TextEditingController> customFieldControllers = {};

  /// ===============================
  /// Buscar os custom fields
  /// ===============================
  Future<void> getCustomFields() async {
    try {
      final response = await clickupController.getCustomFields();
      if (response.data != null) {
        final fields =
            (response.data['fields'] as List)
                .map((field) => ClickupCustomFields.fromMap(field as Map<String, dynamic>))
                .toList();

        customFields.value = fields;

        /// Criar um controller para cada campo
        for (var field in fields) {
          customFieldControllers[field.id] = TextEditingController();
        }
      } else {
        print('Unexpected data format for custom fields: ${response.data}');
      }
    } catch (e) {
      print('Error retrieving custom fields: $e');
    }
  }

  /// ===============================
  /// Criar task no ClickUp
  /// ===============================
  Future<void> createClientTask() async {
    try {
      /// Monta o Map dos custom fields
      final customFieldsData = <String, dynamic>{};

      for (var field in customFields.value) {
        final value = customFieldControllers[field.id]?.text.trim();
        if (value != null && value.isNotEmpty) {
          customFieldsData[field.id] = value;
        }
      }

      /// Define o nome como primeiro campo obrigatório preenchido, ou um padrão
      final name = customFields.value.firstWhere((field) => field.required, orElse: () => customFields.value.first);
      final nameValue = customFieldControllers[name.id]?.text.trim() ?? 'Novo Cliente';

      /// Envia para a API
      final response = await clickupController.createTask(
        name: nameValue.isNotEmpty ? nameValue : 'Novo Cliente',
        customFields: customFieldsData,
      );

      print('Task criada com sucesso: ${response.data}');
    } catch (e) {
      print('Erro ao criar task: $e');
    }
  }

  /// ===============================
  /// Dispose dos controllers
  /// ===============================
  void disposeControllers() {
    for (var controller in customFieldControllers.values) {
      controller.dispose();
    }
    customFieldControllers.clear();
  }
}
