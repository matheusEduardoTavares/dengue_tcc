class MapUtils {
  MapUtils._();

  static String getUrl(String mapStyle) {
    return 'https://api.mapbox.com/styles/v1/mapbox/$mapStyle/tiles/{z}/{x}/{y}?access_token={accessToken}';
  }
}
