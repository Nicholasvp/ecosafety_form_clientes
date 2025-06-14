// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClickupCustomFields {
  final String id;
  final String name;
  final String type;
  final bool required;

  ClickupCustomFields({required this.id, required this.name, required this.type, required this.required});

  ClickupCustomFields copyWith({String? id, String? name, String? type, bool? required}) {
    return ClickupCustomFields(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      required: required ?? this.required,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'type': type, 'required': required};
  }

  factory ClickupCustomFields.fromMap(Map<String, dynamic> map) {
    try {
      return ClickupCustomFields(
        id: map['id'] as String,
        name: map['name'] as String,
        type: map['type'] as String,
        required: map['required'] as bool,
      );
    } catch (e) {
      print('Error in ClickupCustomFields.fromMap: $e');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory ClickupCustomFields.fromJson(String source) =>
      ClickupCustomFields.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClickupCustomFields(id: $id, name: $name, type: $type, required: $required)';
  }

  @override
  bool operator ==(covariant ClickupCustomFields other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.type == type && other.required == required;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode ^ required.hashCode;
  }
}
