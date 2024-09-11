// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/models/Offer.dart';

class OfferLine {
  final int id;
  final int of_id;
  final int h_id;
  final Offer offers;
  OfferLine({
    required this.id,
    required this.of_id,
    required this.h_id,
    required this.offers,
  });

  OfferLine copyWith({
    int? id,
    int? of_id,
    int? h_id,
    Offer? offers,
  }) {
    return OfferLine(
      id: id ?? this.id,
      of_id: of_id ?? this.of_id,
      h_id: h_id ?? this.h_id,
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'of_id': of_id,
      'h_id': h_id,
      'offers': offers.toMap(),
    };
  }

  factory OfferLine.fromMap(Map<String, dynamic> map) {
    return OfferLine(
      id: map['id'] as int,
      of_id: map['of_id'] as int,
      h_id: map['h_id'] as int,
      offers: Offer.fromMap(map['offers'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferLine.fromJson(String source) =>
      OfferLine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfferLine(id: $id, of_id: $of_id, h_id: $h_id, offers: $offers)';
  }

  @override
  bool operator ==(covariant OfferLine other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.of_id == of_id &&
        other.h_id == h_id &&
        other.offers == offers;
  }

  @override
  int get hashCode {
    return id.hashCode ^ of_id.hashCode ^ h_id.hashCode ^ offers.hashCode;
  }
}
