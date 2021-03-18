import 'dart:io';

class EnvironmentConfig {
  // dev:
  // http://localhost:4000/graphql ios and web
  // https://developer.android.com/studio/run/emulator-networking
  // http://10.0.2.2:4000/graphql android
  // Sandbox: https://spotme-api-sandbox.herokuapp.com/graphql
  static String gethost() => Platform.isAndroid ? '10.0.2.2' : 'localhost';

  /// To be available via fromEnvironment() calll
  /// these env variables must be added to the codemagic build command via --dart-defines
  static String graphqlEndpoint = String.fromEnvironment(
      'SPOTME_GRAPHQL_ENDPOINT',
      defaultValue: 'http://${EnvironmentConfig.gethost()}:4000/graphql');

  // Either from ENV or local (ios, web or android)
  static Uri getRestApiEndpoint(String endpoint) {
    final _isLocal = !bool.hasEnvironment('SPOTME_REST_API_ENDPOINT');

    return _isLocal
        // Use raw Uri due to host setting issues with other constructors
        ? Uri(
            scheme: 'http', host: gethost(), port: 4000, path: '/api/$endpoint')
        : Uri.https(
            String.fromEnvironment('SPOTME_REST_API_ENDPOINT',
                defaultValue: ''),
            '/$endpoint');
  }

  static String get uploadCarePublicKey =>
      const String.fromEnvironment('UPLOADCARE_PUBLIC_KEY');

  static String get uploadCarePrivateKey =>
      const String.fromEnvironment('UPLOADCARE_PRIVATE_KEY');
}
