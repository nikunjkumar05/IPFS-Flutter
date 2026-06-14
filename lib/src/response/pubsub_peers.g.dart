// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubsub_peers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubSubPeersResponse _$PubSubPeersResponseFromJson(Map<String, dynamic> json) =>
    PubSubPeersResponse(
      strings:
          (json['Strings'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PubSubPeersResponseToJson(
        PubSubPeersResponse instance) =>
    <String, dynamic>{
      'Strings': instance.strings,
    };
