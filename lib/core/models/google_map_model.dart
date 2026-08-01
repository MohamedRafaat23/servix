import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionModel {
  late LatLng position;

  PositionModel({required double latitude, required double longitude})
      : position = LatLng(latitude, longitude);

  PositionModel.fromJson(LatLng latLng) {
    position = latLng;
  }
}

class MarkerModel {
  final Marker marker;

  const MarkerModel._(this.marker);

  factory MarkerModel({
    required String markerId,
    required PositionModel position,
    BitmapDescriptorModel? icon,
  }) {
    return MarkerModel._(
      Marker(
        markerId: MarkerId(markerId),
        position: position.position,
        icon: icon == null
            ? BitmapDescriptor.defaultMarker
            : icon.bitmapDescriptor,
      ),
    );
  }

  MarkerId get markerId => marker.markerId;
  LatLng get position => marker.position;
}

class BitmapDescriptorModel {
  final BitmapDescriptor bitmapDescriptor;

  const BitmapDescriptorModel(this.bitmapDescriptor);

  static Future<BitmapDescriptor> updateImage({
    required String icon,
    Size? size,
  }) async {
    return  BitmapDescriptor.asset(
      ImageConfiguration(size: size),
      icon,
    );
  }
}

class LatLngBoundsModel {
  final PositionModel northEast;
  final PositionModel southWest;

  const LatLngBoundsModel({required this.northEast, required this.southWest});

  LatLngBounds toGoogle() => LatLngBounds(
        northeast: LatLng(
          northEast.position.latitude,
          northEast.position.longitude,
        ),
        southwest: LatLng(
          southWest.position.latitude,
          southWest.position.longitude,
        ),
      );
}
