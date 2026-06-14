import 'package:json_annotation/json_annotation.dart';

part 'swarm.g.dart';

@JsonSerializable(explicitToJson: true)
class SwarmResponse {
  @JsonKey(name: 'Message')
  String? message;

  SwarmResponse({this.message});

  factory SwarmResponse.fromJson(Map<String, dynamic> json) => _$SwarmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwarmResponseToJson(this);
}
