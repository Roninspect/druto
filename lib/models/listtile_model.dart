// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TileItem {
  final String name;
  final Icon icon;
  TileItem({
    required this.name,
    required this.icon,
  });

  @override
  bool operator ==(covariant TileItem other) {
    if (identical(this, other)) return true;

    return other.name == name && other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}
