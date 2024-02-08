# Fahrplanauskunfts App

## Overview

Fahrplanauskunfts App is a Flutter application designed to provide users with public transportation information. The app allows users to search for locations, view schedules, plan routes, and save favorite locations or routes for quick access.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Charizard17/fahrplanauskunfts_app
   ```

2. Navigate to the project directory:

   ```bash
   cd fahrplanauskunfts_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Usage

1. **Search for locations:** Enter a search query to find specific locations.
2. **Select location from the list:** Select a location to view its schedule and route information.
3. **View location details:** View location details and also a map view.
4. **Use selected location:** TODO..

## Supported Platforms

- **Android:** Android 7 and above.
- **iOS:** iOS 14 and above.

## Dependencies

- **http:** - Used for making HTTP requests to retrieve transportation data.
- **shimmer:** - Provides a shimmer effect for loading placeholders in the UI.
- **flutter_map:** - Enables the integration of interactive maps into the application.
- **latlong2:** - Provides support for geographical coordinates and calculations.
- **flutter_test:** for writing unit and widget tests.

## API

- **MVV API:** this app uses MVV API for getting locations list

## Running Tests

To run tests for the app, execute the following command in the terminal:

```bash
flutter test
```

This command will execute all the tests defined in the project, ensuring the correctness and stability of the app's functionality.
