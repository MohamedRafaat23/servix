import 'package:flutter/material.dart';

import '../../models/google_map_model.dart';

abstract class MapService {
  Widget buildMap({
    required ValueChanged<PositionModel> onTap,
    Set<MarkerModel> markers = const {},
    PositionModel? initialPosition,
  });

  void moveTo(PositionModel position);
  Future<PositionModel?> getCurrentLocation();
  void zoomIn();
  void zoomOut();
}
