import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../services/restaurant_service.dart';

/// Provider that handles the fetching of restaurant data.
final restaurantProvider = FutureProvider<List<Restaurant>>((ref) async {
  return RestaurantService.fetchRestaurants();
});

/// Provider that handles the search query state.
final searchQueryProvider = StateProvider<String>((ref) => '');