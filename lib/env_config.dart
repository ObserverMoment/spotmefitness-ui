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
      defaultValue: 'http://${EnvironmentConfig.gethost()}:4000/graphql/');

  static Uri getRegisterEndpoint() {
    final _endpoint =
        String.fromEnvironment('SPOTME_API_ENDPOINT', defaultValue: 'local');
    if (_endpoint == 'local') {
      return Uri.http(EnvironmentConfig.gethost(), '/api/register');
    } else {
      return Uri.https(_endpoint, '/api/register');
    }
  }

  static String get uploadCarePublicKey =>
      const String.fromEnvironment('UPLOADCARE_PUBLIC_KEY');

  static String get uploadCarePrivateKey =>
      const String.fromEnvironment('UPLOADCARE_PRIVATE_KEY');
}
