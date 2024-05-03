// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cart {
  int? id;
  final int pl_id;
  final int p_id;
  final int quantity;
  String? uid;
  Cart({
    this.id,
    required this.pl_id,
    required this.p_id,
    required this.quantity,
    this.uid,
  });

  Cart copyWith({
    int? id,
    int? pl_id,
    int? p_id,
    int? quantity,
    String? uid,
  }) {
    return Cart(
      id: id ?? this.id,
      pl_id: pl_id ?? this.pl_id,
      p_id: p_id ?? this.p_id,
      quantity: quantity ?? this.quantity,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toRemoteMap() {
    return <String, dynamic>{
      'pl_id': pl_id,
      'p_id': p_id,
      'quantity': quantity,
      'uid': uid,
    };
  }

  Map<String, dynamic> toLocalMap() {
    return <String, dynamic>{
      'pl_id': pl_id,
      'p_id': p_id,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] != null ? map['id'] as int : null,
      pl_id: map['pl_id'] as int,
      p_id: map['p_id'] as int,
      quantity: map['quantity'] as int,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toLocalMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, pl_id: $pl_id, p_id: $p_id, quantity: $quantity, uid: $uid)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pl_id == pl_id &&
        other.p_id == p_id &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return id.hashCode ^ pl_id.hashCode ^ p_id.hashCode ^ uid.hashCode;
  }
}
