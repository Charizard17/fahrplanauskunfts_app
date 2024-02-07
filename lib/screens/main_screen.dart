import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';
import 'package:fahrplanauskunfts_app/widgets/location_details.dart';
import 'package:fahrplanauskunfts_app/widgets/location_list_item_shimmer.dart';
import 'package:fahrplanauskunfts_app/widgets/location_resutls_list.dart';
import 'package:fahrplanauskunfts_app/services/location_search_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Location>> _searchFuture;
  Location? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _searchFuture = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fahrplanauskunfts App',
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16.0),
              Expanded(child: _buildSearchResultsWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        const Icon(Icons.location_pin),
        Expanded(
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: _performSearchLocations,
            decoration: InputDecoration(
              hintText: 'Ort eingeben',
              suffixIcon: IconButton(
                onPressed: _clearSearchQuery,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _performSearchLocations(_searchController.text),
        ),
      ],
    );
  }

  Widget _buildSearchResultsWidget() {
    if (_searchController.text.isEmpty) {
      return SizedBox(
        width: 200,
        child: Image.asset('assets/images/itinerary.png'),
      );
    } else {
      return FutureBuilder<List<Location>>(
        future: _searchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerList();
          } else if (snapshot.hasError || snapshot.data!.isEmpty) {
            return _buildNoResultsFound();
          } else {
            return LocationResultsList(
              results: snapshot.data!,
              onItemSelected: _showLocationDetails,
            );
          }
        },
      );
    }
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => const LocationListItemShimmer(),
    );
  }

  Widget _buildNoResultsFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Es wurden keine Orte gefunden.."),
        SizedBox(
          width: 200,
          child: Image.asset('assets/images/itinerary.png'),
        ),
      ],
    );
  }

  void _performSearchLocations(String searchText) {
    setState(() {
      _searchFuture = LocationSearchService().searchLocations(searchText);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchController.clear();
    });
  }

  void _showLocationDetails(Location location) {
    setState(() {
      _selectedLocation = location;
    });
    _showLocationDetailsBottomSheet(context);
  }

  void _showLocationDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LocationDetails(selectedResult: _selectedLocation!);
      },
    );
  }
}
