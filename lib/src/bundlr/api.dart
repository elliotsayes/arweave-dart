import 'package:http/http.dart' as http;

import 'gateway_common.dart';

class BundlrApi {
  final Uri nodeUrl;

  final http.Client _client;

  BundlrApi({
    Uri? nodeUrl,
  })  : nodeUrl = nodeUrl ?? getDefaultNodeUrl(),
        _client = http.Client();

  Future<http.Response> get(String endpoint) =>
      _client.get(_getEndpointUri(endpoint));

  Future<http.Response> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) {
    final url = _getEndpointUri(endpoint);
    print(url);
    return _client.post(url, body: body, headers: headers);
  }

  Uri _getEndpointUri(String path) => Uri.parse('${nodeUrl.origin}/$path');
}
