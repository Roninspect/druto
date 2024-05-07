// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/core/constants/order_enums.dart';
import 'package:fpdart/fpdart.dart';

class OrderProducts {
  int? id;
  final int o_id;
  int? pl_id;
  int? pckg_id;
  final OrderType order_type;
  OrderProducts({
    this.id,
    required this.o_id,
    this.pl_id,
    this.pckg_id,
    required this.order_type,
  });

  OrderProducts copyWith({
    int? id,
    int? o_id,
    int? pl_id,
    int? pckg_id,
    OrderType? order_type,
  }) {
    return OrderProducts(
      id: id ?? this.id,
      o_id: o_id ?? this.o_id,
      pl_id: pl_id ?? this.pl_id,
      pckg_id: pckg_id ?? this.pckg_id,
      order_type: order_type ?? this.order_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'o_id': o_id,
      'pl_id': pl_id ?? pl_id,
      'pckg_id': pckg_id ?? pckg_id,
      'order_type': order_type.name,
    };
  }

  factory OrderProducts.fromMap(Map<String, dynamic> map) {
    return OrderProducts(
      id: map['id'] != null ? map['id'] as int : null,
      o_id: map['o_id'] as int,
      pl_id: map['pl_id'] != null ? map['pl_id'] as int : null,
      pckg_id: map['pckg_id'] != null ? map['pckg_id'] as int : null,
      order_type: OrderType.values[map['order_type']],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProducts.fromJson(String source) =>
      OrderProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProducts(id: $id, o_id: $o_id, pl_id: $pl_id, pckg_id: $pckg_id, order_type: $order_type)';
  }

  @override
  bool operator ==(covariant OrderProducts other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.o_id == o_id &&
        other.pl_id == pl_id &&
        other.pckg_id == pckg_id &&
        other.order_type == order_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        o_id.hashCode ^
        pl_id.hashCode ^
        pckg_id.hashCode ^
        order_type.hashCode;
  }
}
