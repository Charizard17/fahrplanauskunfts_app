import 'dart:convert';

import 'package:fahrplanauskunfts_app/models/location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:fahrplanauskunfts_app/services/api_location_search_service.dart';

void main() {
  final jsonData = {
    'locations': [
      {
        'id': '1',
        'name': 'Location 1',
        'type': 'Type 1',
        'disassembledName': 'Location 1 Disassembled',
        'matchQuality': 100,
        'coord': [11.18764, 47.96803],
        'isBest': false,
      },
      {
        'id': '2',
        'name': 'Location 2',
        'type': 'Type 2',
        'disassembledName': 'Location 2 Disassembled',
        'matchQuality': 90,
        'coord': [11.43509, 48.14444],
        'isBest': false,
      },
    ]
  };

  group('ApiLocationSearchService', () {
    test('fetchLocations returns response from HTTP client', () async {
      final client = MockClient((request) async {
        return http.Response('{"locations": []}', 200);
      });

      final apiLocationSearchService = ApiLocationSearchService();

      final response =
          await apiLocationSearchService.fetchLocations('query', client);

      expect(response.statusCode, equals(200));
    });

    test('parseResponse returns parsed JSON data', () {
      final parsedData = ApiLocationSearchService()
          .parseResponse(http.Response(jsonEncode(jsonData), 200));

      expect(parsedData, isA<Map<String, dynamic>>());
      expect(parsedData.containsKey('locations'), true);
      expect(parsedData['locations'], isA<List>());
    });

    test('parseLocations returns list of Location objects', () {
      final locations = ApiLocationSearchService().parseLocations(jsonData);

      expect(locations, isA<List>());
      expect(locations.length, equals(2));
      expect(locations[0].id, equals('1'));
      expect(locations[0].name, equals('Location 1'));
      expect(locations[1].id, equals('2'));
      expect(locations[1].name, equals('Location 2'));
    });

    test('parseLocations throws exception for unexpected response format', () {
      const String invalidData = 'not a map';

      expect(() => ApiLocationSearchService().parseLocations(invalidData),
          throwsA(isA<Exception>()));
    });

    test(
      'searchLocations returns list of Location objects for successful response',
      () async {
        final client = MockClient((request) async {
          return http.Response(jsonEncode(jsonData), 200);
        });

        final apiLocationSearchService = ApiLocationSearchService();

        final locations =
            await apiLocationSearchService.searchLocations('query', client);

        expect(locations, isA<List<Location>>());
        expect(locations.length, equals(2));
        expect(locations[0].id, equals('1'));
        expect(locations[0].name, equals('Location 1'));
        expect(locations[1].id, equals('2'));
        expect(locations[1].name, equals('Location 2'));
      },
    );

    test('searchLocations throws exception for unsuccessful response',
        () async {
      final client = MockClient((request) async {
        return http.Response('', 404);
      });

      final apiLocationSearchService = ApiLocationSearchService();

      try {
        await apiLocationSearchService.searchLocations('query', client);
        fail('Exception expected but not thrown');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('Fehler beim Laden der Daten'));
      }
    });
  });
}
