import 'dart:convert';

class Package {
  int? id;
  final String name;
  final String cover;

  Package({
    this.id,
    required this.name,
    required this.cover,
  });

  Package copyWith({
    int? id,
    String? name,
    String? cover,
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover': cover,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      cover: map['cover'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Package(id: $id, name: $name, cover: $cover)';
  }

  @override
  bool operator ==(covariant Package other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.cover == cover;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ cover.hashCode;
  }
}
