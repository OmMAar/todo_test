class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://api.openweathermap.org";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";



  static const String weatherInfoUrl = baseUrl + "/data/2.5/forecast";
}