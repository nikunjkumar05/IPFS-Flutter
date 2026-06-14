// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Id _$IdFromJson(Map<String, dynamic> json) => Id(
      id: json['ID'] as String?,
      publicKey: json['PublicKey'] as String?,
      addresses: (json['Addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      agentVersion: json['AgentVersion'] as String?,
      protocolVersion: json['ProtocolVersion'] as String?,
    );

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      'ID': instance.id,
      'PublicKey': instance.publicKey,
      'Addresses': instance.addresses,
      'AgentVersion': instance.agentVersion,
      'ProtocolVersion': instance.protocolVersion,
    };
