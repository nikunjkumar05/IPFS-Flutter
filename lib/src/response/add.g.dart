// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Add _$AddFromJson(Map<String, dynamic> json) => Add(
      bytes: (json['Bytes'] as num?)?.toInt(),
      hash: json['Hash'] as String,
      name: json['Name'] as String,
      size: json['Size'] as String,
    );

Map<String, dynamic> _$AddToJson(Add instance) => <String, dynamic>{
      'Bytes': instance.bytes,
      'Hash': instance.hash,
      'Name': instance.name,
      'Size': instance.size,
    };
