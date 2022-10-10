class ApiDefinitions {
  ApiDefinitions._();

  static String getBaseUrl({
    required String url,
  }) =>
      'http://$url';

  static const marker = '/alerts';
  static const addMarker = '/create_alert';
  static const signin = '/login';
  static const signup = '/cadastro';
  static const logout = '/logout';
  static const refreshToken = '/logout';
}
