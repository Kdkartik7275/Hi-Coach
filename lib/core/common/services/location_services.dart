import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hi_coach/core/conifg/keys.dart';
import 'package:hi_coach/models/placemodel.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class LocationServices {
  Future<List<PlaceModel>> getSuggestions(
      {required String input, required String sessionToken}) async {
    try {
      String kGooglePlacesAPI = "AIzaSyCjKpwObSb4JnJZxTbeYzgAN_Ttn8f2zOU";
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          '$baseURL?input=$input&key=$kGooglePlacesAPI&sessiontoken=$sessionToken';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var predictions = jsonDecode(response.body)['predictions'] as List;
        List<PlaceModel> places = predictions.map((prediction) {
          return PlaceModel(
            description: prediction['description'],
            placeID: prediction['place_id'],
            types: prediction['types'],
          );
        }).toList();
        return places;
      } else {
        throw "Something went wrong. Please try again later";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List> getAreas(String input) async {
    try {
      String kGooglePlacesAPI = "AIzaSyCjKpwObSb4JnJZxTbeYzgAN_Ttn8f2zOU";
      String baseURL =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          '$baseURL?input=$input&key=$kGooglePlacesAPI&sessiontoken=${const Uuid().v4()}';

      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var predictions = jsonDecode(response.body)['predictions'] as List;

        final areas = predictions.map((prediction) {
          return prediction['structured_formatting']['main_text'];
        }).toList();
        return areas;
      } else {
        throw "Something went wrong. Please try again later";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    String kGoogleGeocodingAPI =
        "AIzaSyCjKpwObSb4JnJZxTbeYzgAN_Ttn8f2zOU"; // Replace with your Geocoding API key
    String baseURL = "https://maps.googleapis.com/maps/api/geocode/json";
    String request = '$baseURL?address=$address&key=$kGoogleGeocodingAPI';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var results = jsonDecode(response.body)['results'] as List;
      if (results.isNotEmpty) {
        var geometry = results[0]['geometry'];
        var location = geometry['location'];
        double lat = location['lat'];
        double lng = location['lng'];

        return LatLng(lat, lng);
      } else {
        throw "No results found";
      }
    } else {
      throw "Something went wrong. Please try again later";
    }
  }
}
