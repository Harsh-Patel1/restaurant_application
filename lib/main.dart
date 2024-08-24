import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/restaurant_providers.dart';

// Entry point of the app
void main() {
  // We use ProviderScope to set up Riverpod's state management
  runApp(const ProviderScope(child: MyApp()));
}

// This is the root widget of the app
class MyApp extends StatelessWidget {
  // Adding a key parameter to the constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Basic app color theme
      ),
      home: const RestaurantListScreen(), // The main screen of the app
    );
  }
}

// This widget displays the list of restaurants and a search bar
class RestaurantListScreen extends ConsumerWidget {
  // Adding a key parameter to the constructor
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the restaurantProvider to get the list of restaurants
    final restaurantsAsyncValue = ref.watch(restaurantProvider);
    // Watching the searchQueryProvider to get the current search query
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'), // AppBar with the title "Restaurants"
      ),
      body: Column(
        children: [
          // Search Bar at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search', // Hint text inside the search bar
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Update the search query state when user types in the search bar
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          // The list of restaurants below the search bar
          Expanded(
            child: restaurantsAsyncValue.when(
              // If the data is loaded, show the restaurant list
              data: (restaurants) {
                // Filter restaurants based on the search query
                final filteredRestaurants = restaurants
                    .where((restaurant) => restaurant.name
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

                // Display the filtered restaurant list
                return ListView.builder(
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredRestaurants[index].name),
                    );
                  },
                );
              },
              // While loading, show a loading spinner
              loading: () => const Center(child: CircularProgressIndicator()),
              // If there's an error, display the error message
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
