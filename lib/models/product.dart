// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int? id;
  final String name;
  final String pic;
  final int category;
  final String weight;
  final String details;
  Product({
    this.id,
    required this.name,
    required this.pic,
    required this.category,
    required this.weight,
    required this.details,
  });

  Product copyWith({
    int? id,
    String? name,
    String? pic,
    int? category,
    String? weight,
    String? details,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      pic: pic ?? this.pic,
      category: category ?? this.category,
      weight: weight ?? this.weight,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pic': pic,
      'category': category,
      'weight': weight,
      'details': details,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      pic: map['pic'] as String,
      category: map['category'] as int,
      weight: map['weight'] as String,
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, pic: $pic, category: $category, weight: $weight, details: $details)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.pic == pic &&
        other.category == category &&
        other.weight == weight &&
        other.details == details;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        pic.hashCode ^
        category.hashCode ^
        weight.hashCode ^
        details.hashCode;
  }
}
