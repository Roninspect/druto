// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PackageCategory {
  int? id;
  final String name;
  final String pic;
  PackageCategory({
    this.id,
    required this.name,
    required this.pic,
  });

  PackageCategory copyWith({
    int? id,
    String? name,
    String? pic,
  }) {
    return PackageCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      pic: pic ?? this.pic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'pic': pic,
    };
  }

  factory PackageCategory.fromMap(Map<String, dynamic> map) {
    return PackageCategory(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      pic: map['pic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageCategory.fromJson(String source) =>
      PackageCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PackageCategory(id: $id, name: $name, pic: $pic)';

  @override
  bool operator ==(covariant PackageCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.pic == pic;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ pic.hashCode;
}
