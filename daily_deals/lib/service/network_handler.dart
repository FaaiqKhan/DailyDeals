class NetworkHandler {
  String? _url, endPoint;

  NetworkHandler({this.endPoint}) {
    _url = 'https://hitsofficialuae.com/ddeals/api${this.endPoint}';
  }

  String get getUrl {
    return _url!;
  }

  set updateEndpoint(String endpoint) {
    _url = 'https://hitsofficialuae.com/ddeals/api$endpoint';
  }
}