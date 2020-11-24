// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';
import '../../utils/json_converter/color.dart';
import '../../utils/money.dart';
import '../../utils/json_converter/money.dart';

import '../model/transaction.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  Tag();

  int id;
  String title;
  @ColorConverter()
  Color color;

  TagEdges edges;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Tag && id == other.id;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class TagEdges {
  TagEdges();

  List<Transaction> transactions;

  factory TagEdges.fromJson(Map<String, dynamic> json) =>
      _$TagEdgesFromJson(json);
  Map<String, dynamic> toJson() => _$TagEdgesToJson(this);
}
