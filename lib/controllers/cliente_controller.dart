// ignore_for_file: avoid_print

import 'package:ecosafety_form_clientes/controllers/clickup_controller.dart';
import 'package:ecosafety_form_clientes/models/clickup_custom_fields.dart';
import 'package:flutter/material.dart';

class ClienteController {
  final ClickupController clickupController = ClickupController();

  ValueNotifier<List<ClickupCustomFields>> customFields = ValueNotifier<List<ClickupCustomFields>>([]);

  final Map<String, TextEditingController> customFieldControllers = {};

  Future<void> getCustomFields() async {
    try {
      final response = await clickupController.getCustomFields();
      if (response.data != null) {
        final fields =
            (response.data['fields'] as List)
                .map((field) => ClickupCustomFields.fromMap(field as Map<String, dynamic>))
                .toList();

        customFields.value = fields;

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

  Future<void> createClientTask() async {
    try {
      final customFieldsData = <String, dynamic>{};

      for (var field in customFields.value) {
        final value = customFieldControllers[field.id]?.text.trim();
        if (value != null && value.isNotEmpty) {
          customFieldsData[field.id] = value;
        }
      }

      final name = customFields.value.firstWhere((field) => field.required, orElse: () => customFields.value.first);
      final nameValue = customFieldControllers[name.id]?.text.trim() ?? 'Novo Cliente';

      final response = await clickupController.createTask(
        name: nameValue.isNotEmpty ? nameValue : 'Novo Cliente',
        customFields: customFieldsData,
      );

      print('Task criada com sucesso: ${response.data}');
    } catch (e) {
      print('Erro ao criar task: $e');
    }
  }

  void disposeControllers() {
    for (var controller in customFieldControllers.values) {
      controller.dispose();
    }
    customFieldControllers.clear();
  }
}
