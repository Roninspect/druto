// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/models/product_line.dart';

class OfferItem {
  final int id;
  final int of_id;
  final int pl_id;
  final ProductLine product_line;
  OfferItem({
    required this.id,
    required this.of_id,
    required this.pl_id,
    required this.product_line,
  });

  OfferItem copyWith({
    int? id,
    int? of_id,
    int? pl_id,
    ProductLine? product_line,
  }) {
    return OfferItem(
      id: id ?? this.id,
      of_id: of_id ?? this.of_id,
      pl_id: pl_id ?? this.pl_id,
      product_line: product_line ?? this.product_line,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'of_id': of_id,
      'pl_id': pl_id,
      'product_line': product_line.toMap(),
    };
  }

  factory OfferItem.fromMap(Map<String, dynamic> map) {
    return OfferItem(
      id: map['id'] as int,
      of_id: map['of_id'] as int,
      pl_id: map['pl_id'] as int,
      product_line:
          ProductLine.fromMap(map['product_line'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferItem.fromJson(String source) =>
      OfferItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfferItem(id: $id, of_id: $of_id, pl_id: $pl_id, product_line: $product_line)';
  }

  @override
  bool operator ==(covariant OfferItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.of_id == of_id &&
        other.pl_id == pl_id &&
        other.product_line == product_line;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        of_id.hashCode ^
        pl_id.hashCode ^
        product_line.hashCode;
  }
}
