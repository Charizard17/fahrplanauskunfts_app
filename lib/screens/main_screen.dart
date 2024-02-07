import 'package:fahrplanauskunfts_app/widgets/search_result_details.dart';
import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/search_result.dart';
import 'package:fahrplanauskunfts_app/widgets/search_results_list.dart';
import 'package:fahrplanauskunfts_app/services/search_service.dart';
import 'package:fahrplanauskunfts_app/widgets/shimmer_search_result_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<SearchResult>> _searchFuture;
  SearchResult? _selectedResult;

  @override
  void initState() {
    super.initState();
    _searchFuture = Future.value([]);
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
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _performSearch(_searchController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Ort eingeben',
                      suffixIcon: IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildSearchResultWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultWidget() {
    if (_searchController.text.isEmpty) {
      return SizedBox(
        width: 200,
        child: Image.asset(
          'assets/images/itinerary.png',
        ),
      );
    } else {
      return FutureBuilder<List<SearchResult>>(
        future: _searchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ShimmerSearchResultItem();
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
                  child: SearchResultsList(
                    results: snapshot.data!,
                    onItemSelected: (result) {
                      setState(() {
                        _selectedResult = result;
                      });
                      _showDetailBottomSheet(context);
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

  void _showDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SearchResultDetails(selectedResult: _selectedResult!);
      },
    );
  }

  void _performSearch(String searchText) {
    setState(() {
      _searchFuture = SearchService().searchResult(searchText);
    });
  }
}
