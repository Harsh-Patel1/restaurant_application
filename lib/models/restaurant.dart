/// A model class representing a Restaurant.
///
/// This class has the basic details of a restaurant, including
/// its `id`, `name`, and `cuisine`.
class Restaurant {
  /// The restaurant's unique ID.
  final int id;
  /// The name of the restaurant
  final String name;
  /// The type of food the restaurant serves.
  final String cuisine;

  /// Constructor to create a new Restaurant object.
  ///
  /// All the parameters are required to make sure we have all the necessary
  /// information about the restaurant.
  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
  });

  /// This is a factory method that converts a JSON map into a Restaurant object.
  ///
  /// It's useful when we get restaurant data from an API or a file and need to
  /// turn it into a Restaurant object.
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
    );
  }

  /// This method takes a list of JSON maps and converts them into a list of Restaurant objects.
  ///
  /// This is useful when we're working with multiple restaurants at once.
  static List<Restaurant> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Restaurant.fromJson(json)).toList();
  }
}
