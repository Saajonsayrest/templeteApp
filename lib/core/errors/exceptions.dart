class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'A server exception occurred']);
}
