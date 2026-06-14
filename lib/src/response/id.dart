import 'package:json_annotation/json_annotation.dart';

part 'id.g.dart';

@JsonSerializable(explicitToJson: true)
class Id {
  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'PublicKey')
  String? publicKey;

  @JsonKey(name: 'Addresses')
  List<String>? addresses;

  @JsonKey(name: 'AgentVersion')
  String? agentVersion;

  @JsonKey(name: 'ProtocolVersion')
  String? protocolVersion;

  Id({this.id, this.publicKey, this.addresses, this.agentVersion, this.protocolVersion});

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);
}
