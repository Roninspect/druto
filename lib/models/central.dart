// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Central {
  final int id;
  final String name;
  Central({
    required this.id,
    required this.name,
  });

  Central copyWith({
    int? id,
    String? name,
  }) {
    return Central(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Central.fromMap(Map<String, dynamic> map) {
    return Central(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Central.fromJson(String source) =>
      Central.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Central(id: $id, name: $name)';

  @override
  bool operator ==(covariant Central other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
