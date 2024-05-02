// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Hub {
  int? id;
  final String name;
  final int cId;
  final List<PolygonPoints> polygonPoints;
  Hub({
    this.id,
    required this.name,
    required this.cId,
    required this.polygonPoints,
  });

  Hub copyWith({
    int? id,
    String? name,
    int? cId,
    List<PolygonPoints>? polygonPoints,
  }) {
    return Hub(
      id: id ?? this.id,
      name: name ?? this.name,
      cId: cId ?? this.cId,
      polygonPoints: polygonPoints ?? this.polygonPoints,
    );
  }

  factory Hub.fromMap(Map<String, dynamic> map) {
    return Hub(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      cId: map['c_id'] as int,
      polygonPoints: List<PolygonPoints>.from(
        (map['polygons_points'] as List<dynamic>).map<PolygonPoints>(
          (x) => PolygonPoints.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Hub.fromJson(String source) =>
      Hub.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hub(id: $id, name: $name, cId: $cId, polygonPoints: $polygonPoints)';
  }

  @override
  bool operator ==(covariant Hub other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.cId == cId &&
        listEquals(other.polygonPoints, polygonPoints);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ cId.hashCode ^ polygonPoints.hashCode;
  }
}

class PolygonPoints {
  int? id;
  final num lat;
  final num lng;
  final int h_id;
  PolygonPoints({
    this.id,
    required this.lat,
    required this.lng,
    required this.h_id,
  });

  PolygonPoints copyWith({
    int? id,
    num? lat,
    num? lng,
    int? h_id,
  }) {
    return PolygonPoints(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      h_id: h_id ?? this.h_id,
    );
  }

  factory PolygonPoints.fromMap(Map<String, dynamic> map) {
    return PolygonPoints(
      id: map['id'] != null ? map['id'] as int : null,
      lat: map['lat'] as num,
      lng: map['lng'] as num,
      h_id: map['h_id'] as int,
    );
  }

  factory PolygonPoints.fromJson(String source) =>
      PolygonPoints.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PolygonPoints(id: $id, lat: $lat, lng: $lng, h_id: $h_id)';
  }

  @override
  bool operator ==(covariant PolygonPoints other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lat == lat &&
        other.lng == lng &&
        other.h_id == h_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ lat.hashCode ^ lng.hashCode ^ h_id.hashCode;
  }
}
