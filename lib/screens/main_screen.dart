import 'package:flutter/material.dart';
import 'package:journey_planner_app/models/search_result.dart';
import 'package:journey_planner_app/widgets/search_results_list.dart';
import 'package:journey_planner_app/services/search_service.dart';
import 'package:journey_planner_app/widgets/shimmer_search_result_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<SearchResult>> _searchFuture;

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
          'Journey Planner App',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _performSearch(_searchController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter search text',
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
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Image.asset(
            'assets/images/itinerary.png',
            height: 200.0,
          );
        } else {
          return SearchResultsList(results: snapshot.data!);
        }
      },
    );
  }

  void _performSearch(String searchText) {
    setState(() {
      _searchFuture = SearchService().searchResult(searchText);
    });
  }
}
