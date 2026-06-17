import 'package:chopper/chopper.dart';

import 'json_to_type_converter.dart';
import '../response/add.dart';
import '../response/cat.dart';
import '../response/id.dart';
import '../response/ls.dart';
import '../response/swarm.dart';
import '../response/pubsub_peers.dart';

part 'ipfs_service.chopper.dart';

@ChopperApi(baseUrl: '/api/v0')
abstract class IpfsService extends ChopperService {
  @Post(path: '/add')
  @multipart
  Future<Response<Add>> add(@PartFile('path') List<int> file);

  @Post(path: '/cat', optionalBody: true)
  Future<Response<Cat>> cat(@Query('arg') String arg);

  @Post(path: '/id', optionalBody: true)
  Future<Response<Id>> id();

  @Post(path: '/get', optionalBody: true)
  Future<Response<String>> get(@Query('arg') String arg);

  @Post(path: '/ls', optionalBody: true)
  Future<Response<Ls>> ls(@Query('arg') String arg);

  @Post(path: '/swarm/connect', optionalBody: true)
  Future<Response<SwarmResponse>> swarmConnect(@Query('arg') String arg);

  @Post(path: '/swarm/disconnect', optionalBody: true)
  Future<Response<SwarmResponse>> swarmDisconnect(@Query('arg') String arg);

  @Post(path: '/pubsub/pub', optionalBody: true)
  Future<Response<String>> pubsubPublish(
      @Query('topic') String topic, @Query('arg') String arg);

  @Post(path: '/pubsub/sub', optionalBody: true)
  Future<Response<String>> pubsubSubscribe(@Query('topic') String topic);

  @Post(path: '/pubsub/peers', optionalBody: true)
  Future<Response<PubSubPeersResponse>> pubsubPeers(
      [@Query('topic') String? topic]);

  static IpfsService create(String url) {
    final client = ChopperClient(
        baseUrl: Uri.parse(url),
        services: [_$IpfsService()],
        converter: JsonToTypeConverter({
          Add: (jsonData) => Add.fromJson(jsonData),
          Cat: (jsonData) => Cat.fromJson(jsonData),
          Id: (jsonData) => Id.fromJson(jsonData),
          Ls: (jsonData) => Ls.fromJson(jsonData),
          SwarmResponse: (jsonData) => SwarmResponse.fromJson(jsonData),
          PubSubPeersResponse: (jsonData) =>
              PubSubPeersResponse.fromJson(jsonData),
        }),
        interceptors: [HttpLoggingInterceptor()]);

    return _$IpfsService(client);
  }
}
