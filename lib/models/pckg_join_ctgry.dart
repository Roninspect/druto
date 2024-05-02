// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JoinPckgCtgry {
  int? id;
  final int pckg_id;
  final int pc_id;
  JoinPckgCtgry({
    this.id,
    required this.pckg_id,
    required this.pc_id,
  });

  JoinPckgCtgry copyWith({
    int? id,
    int? pckg_id,
    int? pc_id,
  }) {
    return JoinPckgCtgry(
      id: id ?? this.id,
      pckg_id: pckg_id ?? this.pckg_id,
      pc_id: pc_id ?? this.pc_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pckg_id': pckg_id,
      'pc_id': pc_id,
    };
  }

  factory JoinPckgCtgry.fromMap(Map<String, dynamic> map) {
    return JoinPckgCtgry(
      id: map['id'] != null ? map['id'] as int : null,
      pckg_id: map['pckg_id'] as int,
      pc_id: map['pc_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinPckgCtgry.fromJson(String source) =>
      JoinPckgCtgry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'JoinPckgCtgry(id: $id, pckg_id: $pckg_id, pc_id: $pc_id)';

  @override
  bool operator ==(covariant JoinPckgCtgry other) {
    if (identical(this, other)) return true;

    return other.id == id && other.pckg_id == pckg_id && other.pc_id == pc_id;
  }

  @override
  int get hashCode => id.hashCode ^ pckg_id.hashCode ^ pc_id.hashCode;
}
