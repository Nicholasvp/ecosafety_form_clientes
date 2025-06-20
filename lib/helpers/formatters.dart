import 'package:flutter/services.dart';

final phoneFormatter = [
  // Formata para "+55 84 98636 6695"
  TextInputFormatter.withFunction((oldValue, newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    if (digits.isEmpty) return newValue.copyWith(text: '');

    if (digits.length <= 2) {
      formatted = '+$digits';
    } else if (digits.length <= 4) {
      formatted = '+${digits.substring(0, 2)} ${digits.substring(2)}';
    } else if (digits.length <= 9) {
      formatted = '+${digits.substring(0, 2)} ${digits.substring(2, 4)} ${digits.substring(4)}';
    } else if (digits.length <= 13) {
      formatted =
          '+${digits.substring(0, 2)} ${digits.substring(2, 4)} ${digits.substring(4, 9)} ${digits.substring(9)}';
    } else {
      formatted =
          '+${digits.substring(0, 2)} ${digits.substring(2, 4)} ${digits.substring(4, 9)} ${digits.substring(9, 13)}';
    }

    return TextEditingValue(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }),
];

bool validPhone(String phone) {
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  return phone.startsWith('+') && digits.length == 13;
}
