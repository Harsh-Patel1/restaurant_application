import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/restaurant.dart';

/// A service class that handles loading restaurant data from a JSON file.
class RestaurantService {
  /// Loads restaurant data from the JSON file located in the assets folder.
  ///
  /// Returns a list of `Restaurant` objects.
  static Future<List<Restaurant>> fetchRestaurants() async {
    // Load the JSON file from the assets folder
    final response = await rootBundle.loadString('assets/restaurants.json');
    
    // Decode the JSON data
    List<dynamic> jsonData = json.decode(response);
    
    // Convert the parsed data into a list of Restaurant objects and return it
    return Restaurant.fromJsonList(jsonData);
  }
}
