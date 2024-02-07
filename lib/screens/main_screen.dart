import 'package:fahrplanauskunfts_app/widgets/location_details.dart';
import 'package:fahrplanauskunfts_app/widgets/location_list_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';
import 'package:fahrplanauskunfts_app/widgets/location_resutls_list.dart';
import 'package:fahrplanauskunfts_app/services/location_search_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchQueryController = TextEditingController();
  late Future<List<Location>> _searchLocationsFuture;
  Location? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _searchLocationsFuture = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Row(
              children: [
                const Icon(
                  Icons.location_pin,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchQueryController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _performSearchLocations(_searchQueryController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Ort eingeben',
                      suffixIcon: IconButton(
                        onPressed: _searchQueryController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _performSearchLocations(_searchQueryController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildSearchLocationsWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchLocationsWidget() {
    if (_searchQueryController.text.isEmpty) {
      return SizedBox(
        width: 200,
        child: Image.asset(
          'assets/images/itinerary.png',
        ),
      );
    } else {
      return FutureBuilder<List<Location>>(
        future: _searchLocationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const LocationListItemShimmer();
              },
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${snapshot.error}'),
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    'assets/images/crash.png',
                  ),
                ),
                const Text(""),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Es wurden keine Orte gefunden.."),
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    'assets/images/itinerary.png',
                  ),
                ),
                const Text(""),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: LocationResultsList(
                    results: snapshot.data!,
                    onItemSelected: (result) {
                      setState(() {
                        _selectedLocation = result;
                      });
                      _showLocationDetailsBottomSheet(context);
                    },
                  ),
                ),
              ],
            );
          }
        },
      );
    }
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

  void _performSearchLocations(String searchText) {
    setState(() {
      _searchLocationsFuture =
          LocationSearchService().searchLocations(searchText);
    });
  }
}
