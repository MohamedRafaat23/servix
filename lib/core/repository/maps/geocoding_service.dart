import 'package:dio/dio.dart';
import '../../utils/functions/print_state.dart';

class GeocodingService {
  final Dio _dio = Dio();
  final String _apiKey = "AIzaSyCgLWzEX0BEcgPhUr5NC0mQgxIa7O_5hxA";

  Future<Map<String, dynamic>?> reverseGeocode(double lat, double lng) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '$lat,$lng',
          'key': _apiKey,
          'language': 'en', // Prefer English for matching names
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        final result = response.data['results'][0];
        final addressComponents = result['address_components'] as List;
        
        String? country;
        String? state;
        String? city;
        String? subCity;
        String? area;
        String? neighborhood;
        String? street;
        String? premise;

        for (var component in addressComponents) {
          final types = component['types'] as List;
          final name = component['long_name'];

          if (types.contains('country')) {
            country = name;
          } else if (types.contains('administrative_area_level_1')) {
            state = name;
          } else if (types.contains('administrative_area_level_2')) {
            city = name;
          } else if (types.contains('locality') || types.contains('administrative_area_level_3')) {
            subCity ??= name;
          } else if (types.contains('sublocality_level_1') || 
                     types.contains('sublocality_level_2') || 
                     types.contains('sublocality')) {
            area ??= name;
          } else if (types.contains('neighborhood')) {
            neighborhood = name;
          } else if (types.contains('route')) {
            street = name;
          } else if (types.contains('premise') || types.contains('establishment') || types.contains('point_of_interest')) {
            premise ??= name;
          }
        }

        String formattedAddress = result['formatted_address'] ?? '';
        String? finalStreet = street ?? premise;

        // Ultimate fallback: Extract street from formatted_address (usually the first part before comma)
        if (finalStreet == null && formattedAddress.isNotEmpty) {
          final parts = formattedAddress.split(',');
          if (parts.isNotEmpty) {
            final firstPart = parts.first.trim();
            // Ignore Plus Codes (e.g. 7C4X+Q3, Cairo)
            if (!firstPart.contains('+')) {
              finalStreet = firstPart;
            }
          }
        }

        return {
          'country': country,
          'state': state,
          'city': city,
          'subCity': subCity,
          'area': area ?? neighborhood ?? subCity,
          'street': finalStreet,
          'formatted_address': formattedAddress,
        };
      }
    } catch (e) {
      printState('Geocoding error: $e');
    }
    return null;
  }
}
