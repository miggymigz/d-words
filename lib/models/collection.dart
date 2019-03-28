import 'package:json_annotation/json_annotation.dart';

import 'lesson.dart';

part 'collection.g.dart';

@JsonSerializable(nullable: false)
class Collection {
  const Collection({this.id, this.name, this.lessons});

  final String id;
  final String name;
  final List<Lesson> lessons;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  Collection copyWith({
    String id,
    String name,
    List<Lesson> lessons,
  }) =>
      Collection(
        id: id ?? this.id,
        name: name ?? this.name,
        lessons: lessons ?? this.lessons,
      );
}
