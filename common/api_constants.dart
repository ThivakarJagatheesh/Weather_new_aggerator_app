class ApiConstants {
  ApiConstants();
  static const String newsBaseUurl = "newsapi.org";
  static const String weatherBaseUurl = "api.openweathermap.org";
  static const String newsApiPath = "/v2/";
  static const String weatherApiPath = "/data/2.5/";

  Uri buildUri({
    required String endpoint,
    required String baseUrl,
    required String apiPath,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: baseUrl,
      path: "$apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Uri weather(
    String lat,
    String lon,
  ) =>
      buildUri(
        endpoint: "weather",
        baseUrl: weatherBaseUurl,
        apiPath: weatherApiPath,
        parametersBuilder: () => cityQueryParameters(lat, lon),
      );

  Uri forecast(String lat, String lon, int cnt) => buildUri(
        endpoint: "forecast",
        baseUrl: weatherBaseUurl,
        apiPath: weatherApiPath,
        parametersBuilder: () => cityQueryParameters(lat, lon, cnt: cnt),
      );

  Map<String, dynamic> cityQueryParameters(String lat, String lon, {int? cnt}) {
    String apiKey = "0173724d4abaaa69d8fdb8d90bf13f5e";
    if (cnt != null) {
      return {"lat": lat, "appid": apiKey, "lon": lon, "cnt": cnt};
    }
    return {
      "lat": lat,
      "appid": apiKey,
      "lon": lon,
    };
  }

  Map<String, dynamic> countryQueryParameters(String express, String apiKey) =>
      {
        "q":express,
        "apiKey": apiKey,
      };
}
