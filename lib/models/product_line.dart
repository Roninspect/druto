// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/models/product.dart';

class ProductLine {
  int? id;
  final int pId;
  final int hId;
  final int cId;
  final int quantity;
  final num discountedPrice;
  final num price;
  final num stockAlert;
  final int limit;
  bool? isActive;
  Product? products;
  ProductLine({
    this.id,
    required this.pId,
    required this.hId,
    required this.cId,
    required this.quantity,
    required this.discountedPrice,
    required this.price,
    required this.stockAlert,
    required this.limit,
    this.isActive,
    this.products,
  });

  ProductLine copyWith({
    int? id,
    int? pId,
    int? hId,
    int? cId,
    int? quantity,
    num? discountedPrice,
    num? price,
    num? stockAlert,
    int? limit,
    Product? products,
    bool? isActive,
  }) {
    return ProductLine(
      id: id ?? this.id,
      pId: pId ?? this.pId,
      hId: hId ?? this.hId,
      cId: cId ?? this.cId,
      quantity: quantity ?? this.quantity,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      price: price ?? this.price,
      stockAlert: stockAlert ?? this.stockAlert,
      limit: limit ?? this.limit,
      products: products ?? this.products,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'p_id': pId,
      'h_id': hId,
      'c_id': cId,
      'quantity': quantity,
      'discounted_price': discountedPrice,
      'price': price,
      'stock_alert': stockAlert,
      'limit': limit,
    };
  }

  factory ProductLine.fromMap(Map<String, dynamic> map) {
    return ProductLine(
      id: map['id'] != null ? map['id'] as int : null,
      pId: map['p_id'] as int,
      hId: map['h_id'] as int,
      cId: map['c_id'] as int,
      quantity: map['quantity'] as int,
      discountedPrice: map['discounted_price'] as num,
      price: map['price'] as num,
      stockAlert: map['stock_alert'] as num,
      limit: map['limit'] as int,
      isActive: map['is_active'] != null ? map['is_active'] as bool : null,
      products: map['products'] != null
          ? Product.fromMap(map['products'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductLine.fromJson(String source) =>
      ProductLine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductLine(id: $id, pId: $pId, hId: $hId, cId: $cId, quantity: $quantity, discountedPrice: $discountedPrice, price: $price, stockAlert: $stockAlert, limit: $limit, products: $products)';
  }

  @override
  bool operator ==(covariant ProductLine other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pId == pId &&
        other.hId == hId &&
        other.cId == cId &&
        other.quantity == quantity &&
        other.discountedPrice == discountedPrice &&
        other.price == price &&
        other.stockAlert == stockAlert &&
        other.limit == limit &&
        other.products == products;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pId.hashCode ^
        hId.hashCode ^
        cId.hashCode ^
        quantity.hashCode ^
        discountedPrice.hashCode ^
        price.hashCode ^
        stockAlert.hashCode ^
        limit.hashCode ^
        products.hashCode;
  }
}
