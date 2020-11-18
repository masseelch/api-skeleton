// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..color = const ColorConverter().fromJson(json['color'] as int)
    ..edges = json['edges'] == null
        ? null
        : TagEdges.fromJson(json['edges'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': const ColorConverter().toJson(instance.color),
      'edges': instance.edges?.toJson(),
    };

TagEdges _$TagEdgesFromJson(Map<String, dynamic> json) {
  return TagEdges()
    ..transactions = (json['transactions'] as List)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TagEdgesToJson(TagEdges instance) => <String, dynamic>{
      'transactions': instance.transactions?.map((e) => e?.toJson())?.toList(),
    };
