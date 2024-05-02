// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductCategory {
  int? id;
  final String name;
  String? pic;
  ProductCategory({
    this.id,
    required this.name,
    this.pic,
  });

  ProductCategory copyWith({
    int? id,
    String? name,
    String? pic,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      pic: pic ?? this.pic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pic': pic,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      pic: map['pic'] != null ? map['pic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(id: $id, name: $name, pic: $pic)';

  @override
  bool operator ==(covariant ProductCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.pic == pic;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ pic.hashCode;
}
