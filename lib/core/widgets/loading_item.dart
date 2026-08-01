import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/constants/app_colors.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color ?? AppColors.primaryColor,
        size: 60,
      ),
    );
  }
}
