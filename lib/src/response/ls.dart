import 'package:json_annotation/json_annotation.dart';

part 'ls.g.dart';

@JsonSerializable(explicitToJson: true)
class LsEntry {
  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'Type')
  int? type;

  @JsonKey(name: 'Size')
  int? size;

  @JsonKey(name: 'Hash')
  String? hash;

  LsEntry({this.name, this.type, this.size, this.hash});

  factory LsEntry.fromJson(Map<String, dynamic> json) => _$LsEntryFromJson(json);

  Map<String, dynamic> toJson() => _$LsEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Ls {
  @JsonKey(name: 'Objects')
  List<LsObject>? objects;

  Ls({this.objects});

  factory Ls.fromJson(Map<String, dynamic> json) => _$LsFromJson(json);

  Map<String, dynamic> toJson() => _$LsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LsObject {
  @JsonKey(name: 'Hash')
  String? hash;

  @JsonKey(name: 'Links')
  List<LsEntry>? links;

  LsObject({this.hash, this.links});

  factory LsObject.fromJson(Map<String, dynamic> json) => _$LsObjectFromJson(json);

  Map<String, dynamic> toJson() => _$LsObjectToJson(this);
}
