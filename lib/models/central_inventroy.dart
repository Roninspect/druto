// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product.dart';

class CentralInventory {
  int? id;
  final int pId;
  final int stock;
  final int stockAlert;
  final int cId;
  Product? products;
  CentralInventory({
    this.id,
    required this.pId,
    required this.stock,
    required this.stockAlert,
    required this.cId,
    this.products,
  });

  CentralInventory copyWith({
    int? id,
    int? pId,
    int? stock,
    int? stockAlert,
    int? cId,
    Product? products,
  }) {
    return CentralInventory(
      id: id ?? this.id,
      pId: pId ?? this.pId,
      stock: stock ?? this.stock,
      stockAlert: stockAlert ?? this.stockAlert,
      cId: cId ?? this.cId,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'p_id': pId,
      'stock': stock,
      'stock_alert': stockAlert,
      'c_id': cId,
    };
  }

  factory CentralInventory.fromMap(Map<String, dynamic> map) {
    return CentralInventory(
      id: map['id'] != null ? map['id'] as int : null,
      pId: map['p_id'] as int,
      stock: map['stock'] as int,
      stockAlert: map['stock_alert'] as int,
      cId: map['c_id'] as int,
      products: map['products'] != null
          ? Product.fromMap(map['products'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CentralInventory.fromJson(String source) =>
      CentralInventory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CentralInventory(id: $id, pId: $pId, stock: $stock, stockAlert: $stockAlert, cId: $cId, products: $products)';
  }

  @override
  bool operator ==(covariant CentralInventory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pId == pId &&
        other.stock == stock &&
        other.stockAlert == stockAlert &&
        other.cId == cId &&
        other.products == products;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pId.hashCode ^
        stock.hashCode ^
        stockAlert.hashCode ^
        cId.hashCode ^
        products.hashCode;
  }
}
