import 'package:ecosafety_form_clientes/enums/enums.dart';
import 'package:ecosafety_form_clientes/helpers/formatters.dart';
import 'package:ecosafety_form_clientes/models/clickup_custom_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFieldWidget extends StatelessWidget {
  const CustomFieldWidget({super.key, required this.clienteController, required this.customField});

  final TextEditingController clienteController;

  final ClickupCustomFields customField;

  @override
  Widget build(BuildContext context) {
    final typeField = typeFieldFromString(customField.type);

    switch (typeField) {
      case TypeFields.checkbox:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Checkbox(
                value: clienteController.text == 'true',
                onChanged: (bool? value) {
                  clienteController.text = value == true ? 'true' : 'false';
                },
              ),
              Text(customField.name),
              if (customField.required) const Text(' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        );
      case TypeFields.dropDown:
        final options = customField.options?.map((e) => e.value).toList() ?? [];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: options.contains(clienteController.text) ? clienteController.text : null,
            decoration: InputDecoration(labelText: customField.name, border: const OutlineInputBorder()),
            items: options.map((option) => DropdownMenuItem<String>(value: option, child: Text(option))).toList(),
            onChanged: (value) {
              if (value != null) clienteController.text = value;
            },
            validator: (value) {
              if (customField.required && (value == null || value.isEmpty)) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        );
      case TypeFields.date:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: clienteController,
            decoration: InputDecoration(
              labelText: customField.name,
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                clienteController.text = picked.toIso8601String().split('T').first;
              }
            },
            validator: (value) {
              if (customField.required && (value == null || value.isEmpty)) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        );
      case TypeFields.phone:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: clienteController,
            decoration: InputDecoration(labelText: customField.name, border: const OutlineInputBorder()),
            keyboardType: TextInputType.phone,
            inputFormatters: phoneFormatter,
            validator: (value) {
              if (customField.required && (value == null || value.trim().isEmpty)) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        );
      case TypeFields.email:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: clienteController,
            decoration: InputDecoration(labelText: customField.name, border: const OutlineInputBorder()),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (customField.required && (value == null || value.trim().isEmpty)) {
                return 'Campo obrigatório';
              }
              if (value != null && value.isNotEmpty && !RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
                return 'E-mail inválido';
              }
              return null;
            },
          ),
        );
      case TypeFields.number:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: clienteController,
            decoration: InputDecoration(labelText: customField.name, border: const OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (customField.required && (value == null || value.trim().isEmpty)) {
                return 'Campo obrigatório';
              }
              if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                return 'Número inválido';
              }
              return null;
            },
          ),
        );
      case TypeFields.shortText:
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: clienteController,
            decoration: InputDecoration(labelText: customField.name, border: const OutlineInputBorder()),
            validator: (value) {
              if (customField.required && (value == null || value.trim().isEmpty)) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        );
    }
  }
}
