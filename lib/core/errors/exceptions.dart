class AuthException implements Exception {}

class ServerException implements Exception {}

class CacheException implements Exception {}

class GeneralException implements Exception {
  final String message;

  GeneralException(
      {this.message = 'Ocurrió un problema, por favor intente nuevamente'});
}
