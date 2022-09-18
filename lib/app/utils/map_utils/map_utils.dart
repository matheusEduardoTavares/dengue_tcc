class MapUtils {
  MapUtils._();

  static String getUrl(String mapStyle) {
    return 'https://api.mapbox.com/styles/v1/mapbox/$mapStyle/tiles/{z}/{x}/{y}?access_token={accessToken}';
  }

  static const barraBonitaCityCenterLat = -22.47662684956675;
  static const barraBonitaCityCenterLon = -48.56361525904357;
}
