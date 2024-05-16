// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/core/constants/order_enums.dart';

class UserOrder {
  int? id;
  DeliveryStatus? delivery_status;
  final OrderUserType order_user_type;
  final num total_amount;
  final String phone;
  String? uid;
  final String house;
  UserOrder({
    this.id,
    this.delivery_status,
    required this.order_user_type,
    required this.total_amount,
    required this.phone,
    this.uid,
    required this.house,
  });

  UserOrder copyWith({
    int? id,
    DeliveryStatus? delivery_status,
    OrderUserType? order_user_type,
    num? total_amount,
    String? phone,
    String? uid,
    String? house,
  }) {
    return UserOrder(
      id: id ?? this.id,
      delivery_status: delivery_status ?? this.delivery_status,
      order_user_type: order_user_type ?? this.order_user_type,
      total_amount: total_amount ?? this.total_amount,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
      house: house ?? this.house,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_type': order_user_type.name,
      'total_amount': total_amount,
      'phone': phone,
      'uid': uid,
      'house': house,
    };
  }

  factory UserOrder.fromMap(Map<String, dynamic> map) {
    return UserOrder(
      id: map['id'] != null ? map['id'] as int : null,
      delivery_status: DeliveryStatus.values.byName(map['delivery_status']),
      order_user_type: OrderUserType.values.byName(map['user_type']),
      total_amount: map['total_amount'] as num,
      phone: map['phone'] as String,
      uid: map['uid'] != null ? map['uid'] as String : null,
      house: map['house'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOrder.fromJson(String source) =>
      UserOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, delivery_status: $delivery_status, order_user_type: $order_user_type, total_amount: $total_amount, phone: $phone, uid: $uid, house: $house)';
  }

  @override
  bool operator ==(covariant UserOrder other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.delivery_status == delivery_status &&
        other.order_user_type == order_user_type &&
        other.total_amount == total_amount &&
        other.phone == phone &&
        other.uid == uid &&
        other.house == house;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        delivery_status.hashCode ^
        order_user_type.hashCode ^
        total_amount.hashCode ^
        phone.hashCode ^
        uid.hashCode ^
        house.hashCode;
  }
}
