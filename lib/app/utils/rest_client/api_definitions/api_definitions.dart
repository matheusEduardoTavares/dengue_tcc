class ApiDefinitions {
  ApiDefinitions._();

  static String getBaseUrl({
    required String url,
  }) =>
      'http://$url/api/v1';

  static const marker = '/alertas';
  static const addMarker = '/create_alert';
  static const signin = '/usuarios/login';
  static const signup = '/usuarios/signup';
  static const logout = '/logout';
  static const refreshToken = '/logout';
}
