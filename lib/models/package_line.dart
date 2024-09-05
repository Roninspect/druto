// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/models/package.dart';

class PackageLine {
  int? id;
  final int pckg_id;
  final int h_id;
  final bool is_active;
  int? limit;
  int discount;
  Package? package;

  PackageLine({
    this.id,
    required this.pckg_id,
    required this.h_id,
    required this.is_active,
    this.limit,
    required this.discount,
    this.package,
  });

  PackageLine copyWith({
    int? id,
    int? pckg_id,
    int? h_id,
    bool? is_active,
    int? limit,
    Package? package,
    int? discount,
  }) {
    return PackageLine(
        id: id ?? this.id,
        pckg_id: pckg_id ?? this.pckg_id,
        h_id: h_id ?? this.h_id,
        is_active: is_active ?? this.is_active,
        limit: limit ?? this.limit,
        package: package ?? this.package,
        discount: discount ?? this.discount);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pckg_id': pckg_id,
      'h_id': h_id,
      'is_active': is_active,
      'limit': limit,
      'discount': discount
    };
  }

  factory PackageLine.fromMap(Map<String, dynamic> map) {
    return PackageLine(
      id: map['id'] != null ? map['id'] as int : null,
      pckg_id: map['pckg_id'] as int,
      h_id: map['h_id'] as int,
      is_active: map['is_active'] as bool,
      limit: map['limit'] != null ? map['limit'] as int : null,
      discount: map['discount'] as int,
      package: map['packages'] != null
          ? Package.fromMap(map['packages'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageLine.fromJson(String source) =>
      PackageLine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageLine(id: $id, pckg_id: $pckg_id, h_id: $h_id, is_active: $is_active, limit: $limit,discount: $discount, package: $package)';
  }

  @override
  bool operator ==(covariant PackageLine other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pckg_id == pckg_id &&
        other.h_id == h_id &&
        other.is_active == is_active &&
        other.limit == limit &&
        other.discount == discount &&
        other.package == package;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pckg_id.hashCode ^
        h_id.hashCode ^
        is_active.hashCode ^
        limit.hashCode ^
        discount.hashCode ^
        package.hashCode;
  }
}
