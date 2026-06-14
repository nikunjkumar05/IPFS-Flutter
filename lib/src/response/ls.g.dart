// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LsEntry _$LsEntryFromJson(Map<String, dynamic> json) => LsEntry(
      name: json['Name'] as String?,
      type: (json['Type'] as num?)?.toInt(),
      size: (json['Size'] as num?)?.toInt(),
      hash: json['Hash'] as String?,
    );

Map<String, dynamic> _$LsEntryToJson(LsEntry instance) => <String, dynamic>{
      'Name': instance.name,
      'Type': instance.type,
      'Size': instance.size,
      'Hash': instance.hash,
    };

Ls _$LsFromJson(Map<String, dynamic> json) => Ls(
      objects: (json['Objects'] as List<dynamic>?)
          ?.map((e) => LsObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LsToJson(Ls instance) => <String, dynamic>{
      'Objects': instance.objects?.map((e) => e.toJson()).toList(),
    };

LsObject _$LsObjectFromJson(Map<String, dynamic> json) => LsObject(
      hash: json['Hash'] as String?,
      links: (json['Links'] as List<dynamic>?)
          ?.map((e) => LsEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LsObjectToJson(LsObject instance) => <String, dynamic>{
      'Hash': instance.hash,
      'Links': instance.links?.map((e) => e.toJson()).toList(),
    };
