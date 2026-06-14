import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    final body = response.body;

    if (body is String) {
      return response.copyWith<BodyType>(
        body: fromJsonData<BodyType, InnerType>(
            body, typeToJsonFactoryMap[InnerType]),
      );
    }

    return response.copyWith<BodyType>(body: body);
  }

  T fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    if (jsonParser == null) {
      return jsonData as T;
    }

    dynamic jsonMap;
    try {
      jsonMap = json.decode(jsonData);
    } catch (e) {
      jsonMap = json.decode(json.encode({'Body': jsonData}));
    }

    if (jsonMap is List) {
      return jsonMap
          .map((item) => jsonParser(item as Map<String, dynamic>) as InnerType)
          .toList() as T;
    }

    return jsonParser(jsonMap) as T;
  }
}
