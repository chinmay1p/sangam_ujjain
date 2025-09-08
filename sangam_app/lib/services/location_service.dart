import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Check and request location permissions
  static Future<bool> requestLocationPermission() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to get location permission: $e');
    }
  }

  // Get current location
  static Future<Position> getCurrentLocation() async {
    try {
      // Ensure we have permission
      await requestLocationPermission();

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }

  // Get location as formatted string
  static Future<String> getLocationString() async {
    try {
      final position = await getCurrentLocation();
      return 'Latitude: ${position.latitude.toStringAsFixed(6)}, Longitude: ${position.longitude.toStringAsFixed(6)}';
    } catch (e) {
      throw Exception('Failed to get location string: $e');
    }
  }

  // Get location as Google Maps URL
  static Future<String> getGoogleMapsUrl() async {
    try {
      final position = await getCurrentLocation();
      return 'https://www.google.com/maps?q=${position.latitude},${position.longitude}';
    } catch (e) {
      throw Exception('Failed to get Google Maps URL: $e');
    }
  }

  // Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      return permission == LocationPermission.whileInUse || 
             permission == LocationPermission.always;
    } catch (e) {
      return false;
    }
  }

  // Open location settings
  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // Open app settings
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
