// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Offer {
  final int id;
  final String name;
  final String banner;
  final String path;
  Offer({
    required this.id,
    required this.name,
    required this.banner,
    required this.path,
  });

  Offer copyWith({
    int? id,
    String? name,
    String? banner,
    String? path,
  }) {
    return Offer(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'banner': banner,
      'path': path,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] as int,
      name: map['name'] as String,
      banner: map['banner'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Offer(id: $id, name: $name, banner: $banner, path: $path)';
  }

  @override
  bool operator ==(covariant Offer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.banner == banner &&
        other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ banner.hashCode ^ path.hashCode;
  }
}
