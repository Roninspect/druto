// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product_line.dart';

class PackageItem {
  int? id;
  final int pckg_id;
  final int p_id;
  final int pl_id;
  final int item_quantity;
  ProductLine? product_line;
  PackageItem({
    this.id,
    required this.pckg_id,
    required this.item_quantity,
    required this.p_id,
    required this.pl_id,
    this.product_line,
  });

  PackageItem copyWith({
    int? id,
    int? pckg_id,
    int? p_id,
    int? pl_id,
    int? item_quantity,
    ProductLine? product_line,
  }) {
    return PackageItem(
      id: id ?? this.id,
      pckg_id: pckg_id ?? this.pckg_id,
      p_id: p_id ?? this.p_id,
      pl_id: pl_id ?? this.pl_id,
      item_quantity: item_quantity ?? this.item_quantity,
      product_line: product_line ?? this.product_line,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pckg_id': pckg_id,
      'p_id': p_id,
      'pl_id': pl_id,
      "item_quantity": item_quantity
    };
  }

  factory PackageItem.fromMap(Map<String, dynamic> map) {
    return PackageItem(
      id: map['id'] != null ? map['id'] as int : null,
      pckg_id: map['pckg_id'] as int,
      p_id: map['p_id'] as int,
      pl_id: map['pl_id'] as int,
      item_quantity: map['item_quantity'] as int,
      product_line: map['product_line'] != null
          ? ProductLine.fromMap(map['product_line'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageItem.fromJson(String source) =>
      PackageItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageItem(id: $id, pckg_id: $pckg_id, p_id: $p_id, pl_id: $pl_id, product_line: $product_line)';
  }

  @override
  bool operator ==(covariant PackageItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pckg_id == pckg_id &&
        other.p_id == p_id &&
        other.pl_id == pl_id &&
        other.product_line == product_line;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pckg_id.hashCode ^
        p_id.hashCode ^
        pl_id.hashCode ^
        product_line.hashCode;
  }
}
