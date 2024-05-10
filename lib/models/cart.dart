// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cart {
  int? id;
  int? pl_id;
  int? p_id;
  int? pckg_id;
  final int quantity;
  String? uid;
  Cart({
    this.id,
    this.pl_id,
    this.p_id,
    this.pckg_id,
    required this.quantity,
    this.uid,
  });

  Cart copyWith({
    int? id,
    int? pl_id,
    int? p_id,
    int? pckg_id,
    int? quantity,
    String? uid,
  }) {
    return Cart(
      id: id ?? this.id,
      pl_id: pl_id ?? this.pl_id,
      p_id: p_id ?? this.p_id,
      pckg_id: pckg_id ?? this.pckg_id,
      quantity: quantity ?? this.quantity,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pl_id': pl_id,
      'p_id': p_id,
      'pckg_id': pckg_id,
      'quantity': quantity,
      'uid': uid,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] != null ? map['id'] as int : null,
      pl_id: map['pl_id'] != null ? map['pl_id'] as int : null,
      p_id: map['p_id'] != null ? map['p_id'] as int : null,
      pckg_id: map['pckg_id'] != null ? map['pckg_id'] as int : null,
      quantity: map['quantity'] as int,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, pl_id: $pl_id, p_id: $p_id, pckg_id: $pckg_id, quantity: $quantity, uid: $uid)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pl_id == pl_id &&
        other.p_id == p_id &&
        other.pckg_id == pckg_id &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pl_id.hashCode ^
        p_id.hashCode ^
        pckg_id.hashCode ^
        uid.hashCode;
  }
}
