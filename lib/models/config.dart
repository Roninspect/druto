// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Configs {
  final int min_delivery;
  Configs({
    required this.min_delivery,
  });

  Configs copyWith({
    int? min_delivery,
  }) {
    return Configs(
      min_delivery: min_delivery ?? this.min_delivery,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'min_delivery': min_delivery,
    };
  }

  factory Configs.fromMap(Map<String, dynamic> map) {
    return Configs(
      min_delivery: map['min_delivery'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Configs.fromJson(String source) =>
      Configs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Configs(min_delivery: $min_delivery)';

  @override
  bool operator ==(covariant Configs other) {
    if (identical(this, other)) return true;

    return other.min_delivery == min_delivery;
  }

  @override
  int get hashCode => min_delivery.hashCode;
}
