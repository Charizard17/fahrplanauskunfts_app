import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationDetails extends StatelessWidget {
  final Location _selectedResult;

  const LocationDetails({
    Key? key,
    required Location selectedResult,
  })  : _selectedResult = selectedResult,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      widthFactor: 1.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedResult.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ort: ${_selectedResult.disassembledName}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Typ: ${_selectedResult.type}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      _selectedResult.coord[1],
                      _selectedResult.coord[0],
                    ),
                    zoom: 15.0,
                    interactiveFlags: InteractiveFlag.none,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            _selectedResult.coord[1],
                            _selectedResult.coord[0],
                          ),
                          width: 50,
                          height: 50,
                          builder: (BuildContext context) {
                            return const Icon(
                              size: 50,
                              Icons.location_on,
                              color: Colors.blue,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Standort auswählen',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
