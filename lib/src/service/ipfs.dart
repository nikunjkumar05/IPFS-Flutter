import 'package:chopper/chopper.dart';

import 'ipfs_service.dart';
import '../response/add.dart';
import '../response/cat.dart';
import '../response/id.dart';
import '../response/ls.dart';
import '../response/swarm.dart';
import '../response/pubsub_peers.dart';

/// Provides access to IPFS HTTP API.
class Ipfs {
  late IpfsService _service;

  /// Creates new IPFS instance.
  ///
  /// [url] URL for exposed IPFS daemon
  Ipfs({String url = 'http://127.0.0.1:5001'}) {
    _service = IpfsService.create(url);
  }

  IpfsService ipfs() {
    return _service;
  }

  /// Adds bytes to IPFS via '/api/v0/add'.
  Future<Response<Add>> add(List<int> contents) {
    return _service.add(contents);
  }

  /// Reads data from IPFS by CID via '/api/v0/cat'.
  Future<Response<Cat>> cat(String arg) {
    return _service.cat(arg);
  }

  /// Returns identity information of the IPFS node via '/api/v0/id'.
  Future<Response<Id>> id() {
    return _service.id();
  }

  /// Downloads file data from IPFS by CID via '/api/v0/get'.
  Future<Response<String>> get(String arg) {
    return _service.get(arg);
  }

  /// Lists directory contents at a given CID via '/api/v0/ls'.
  Future<Response<Ls>> ls(String arg) {
    return _service.ls(arg);
  }

  /// Connects to a peer via '/api/v0/swarm/connect'.
  Future<Response<SwarmResponse>> swarmConnect(String arg) {
    return _service.swarmConnect(arg);
  }

  /// Disconnects from a peer via '/api/v0/swarm/disconnect'.
  Future<Response<SwarmResponse>> swarmDisconnect(String arg) {
    return _service.swarmDisconnect(arg);
  }

  /// Publishes a message to a pubsub topic via '/api/v0/pubsub/pub'.
  Future<Response<String>> pubsubPublish(String topic, String message) {
    return _service.pubsubPublish(topic, message);
  }

  /// Subscribes to a pubsub topic via '/api/v0/pubsub/sub'.
  Future<Response<String>> pubsubSubscribe(String topic) {
    return _service.pubsubSubscribe(topic);
  }

  /// Lists peers subscribed to a pubsub topic via '/api/v0/pubsub/peers'.
  Future<Response<PubSubPeersResponse>> pubsubPeers([String? topic]) {
    return _service.pubsubPeers(topic);
  }
}
