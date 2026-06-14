// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipfs_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$IpfsService extends IpfsService {
  _$IpfsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = IpfsService;

  @override
  Future<Response<Add>> add(List<int> file) {
    final Uri $url = Uri.parse('/api/v0/add');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>(
        'path',
        file,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<Add, Add>($request);
  }

  @override
  Future<Response<Cat>> cat(String arg) {
    final Uri $url = Uri.parse('/api/v0/cat');
    final Map<String, dynamic> $params = <String, dynamic>{'arg': arg};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Cat, Cat>($request);
  }

  @override
  Future<Response<Id>> id() {
    final Uri $url = Uri.parse('/api/v0/id');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Id, Id>($request);
  }

  @override
  Future<Response<Cat>> get(String arg) {
    final Uri $url = Uri.parse('/api/v0/get');
    final Map<String, dynamic> $params = <String, dynamic>{'arg': arg};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Cat, Cat>($request);
  }

  @override
  Future<Response<Ls>> ls(String arg) {
    final Uri $url = Uri.parse('/api/v0/ls');
    final Map<String, dynamic> $params = <String, dynamic>{'arg': arg};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Ls, Ls>($request);
  }

  @override
  Future<Response<SwarmResponse>> swarmConnect(String arg) {
    final Uri $url = Uri.parse('/api/v0/swarm/connect');
    final Map<String, dynamic> $params = <String, dynamic>{'arg': arg};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SwarmResponse, SwarmResponse>($request);
  }

  @override
  Future<Response<SwarmResponse>> swarmDisconnect(String arg) {
    final Uri $url = Uri.parse('/api/v0/swarm/disconnect');
    final Map<String, dynamic> $params = <String, dynamic>{'arg': arg};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SwarmResponse, SwarmResponse>($request);
  }

  @override
  Future<Response<String>> pubsubPublish(
    String topic,
    String arg,
  ) {
    final Uri $url = Uri.parse('/api/v0/pubsub/pub');
    final Map<String, dynamic> $params = <String, dynamic>{
      'topic': topic,
      'arg': arg,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> pubsubSubscribe(String topic) {
    final Uri $url = Uri.parse('/api/v0/pubsub/sub');
    final Map<String, dynamic> $params = <String, dynamic>{'topic': topic};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<PubSubPeersResponse>> pubsubPeers([String? topic]) {
    final Uri $url = Uri.parse('/api/v0/pubsub/peers');
    final Map<String, dynamic> $params = <String, dynamic>{'topic': topic};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PubSubPeersResponse, PubSubPeersResponse>($request);
  }
}
