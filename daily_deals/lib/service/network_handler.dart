class NetworkHandler {
  String? _url, endPoint;

  NetworkHandler({required this.endPoint}) {
    _url = 'https://hitsofficialuae.com/ddeals/api${this.endPoint}';
  }

  String get getUrl => _url!;

  set updateEndpoint(String endpoint) {
    _url = 'https://hitsofficialuae.com/ddeals/api$endpoint';
  }
}