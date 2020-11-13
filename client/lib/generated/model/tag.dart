// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  Tag();

  int id;
  String title;

  String description;

  TagEdges edges;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class TagEdges {
  TagEdges();

  factory TagEdges.fromJson(Map<String, dynamic> json) =>
      _$TagEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$TagEdgesToJson(this);
}
