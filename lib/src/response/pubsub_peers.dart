import 'package:json_annotation/json_annotation.dart';

part 'pubsub_peers.g.dart';

@JsonSerializable(explicitToJson: true)
class PubSubPeersResponse {
  @JsonKey(name: 'Strings')
  List<String>? strings;

  PubSubPeersResponse({this.strings});

  factory PubSubPeersResponse.fromJson(Map<String, dynamic> json) =>
      _$PubSubPeersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PubSubPeersResponseToJson(this);
}
