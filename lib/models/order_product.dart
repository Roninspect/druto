// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'package:druto/core/constants/order_enums.dart';

class OrderProducts {
  int? id;
  final int o_id;
  int? pl_id;
  int? pckgl_id;
  final OrderType order_type;
  final int quantity;
  OrderProducts({
    this.id,
    required this.o_id,
    this.pl_id,
    this.pckgl_id,
    required this.order_type,
    required this.quantity,
  });

  OrderProducts copyWith({
    int? id,
    int? o_id,
    int? pl_id,
    int? pckgl_id,
    OrderType? order_type,
    int? quantity,
  }) {
    return OrderProducts(
      id: id ?? this.id,
      o_id: o_id ?? this.o_id,
      pl_id: pl_id ?? this.pl_id,
      pckgl_id: pckgl_id ?? this.pckgl_id,
      order_type: order_type ?? this.order_type,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'o_id': o_id,
      'pl_id': pl_id,
      'pckgl_id': pckgl_id,
      'order_type': order_type.name,
      'quantity': quantity,
    };
  }

  factory OrderProducts.fromMap(Map<String, dynamic> map) {
    return OrderProducts(
      id: map['id'] != null ? map['id'] as int : null,
      o_id: map['o_id'] as int,
      pl_id: map['pl_id'] != null ? map['pl_id'] as int : null,
      pckgl_id: map['pckgl_id'] != null ? map['pckgl_id'] as int : null,
      order_type: OrderType.values.byName(map['order_type']),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProducts.fromJson(String source) =>
      OrderProducts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProducts(id: $id, o_id: $o_id, pl_id: $pl_id, pckgl_id: $pckgl_id, order_type: $order_type, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant OrderProducts other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.o_id == o_id &&
        other.pl_id == pl_id &&
        other.pckgl_id == pckgl_id &&
        other.order_type == order_type &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        o_id.hashCode ^
        pl_id.hashCode ^
        pckgl_id.hashCode ^
        order_type.hashCode ^
        quantity.hashCode;
  }
}
