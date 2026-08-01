import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/bannar_entity.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import 'banner_card.dart';
import 'banner_page_indicator.dart';

class PromoBannerCarousel extends StatelessWidget {
  final void Function(BannerEntity banner)? onBookNow;

  const PromoBannerCarousel({super.key, this.onBookNow});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.banners != current.banners ||
          previous.currentBannerIndex != current.currentBannerIndex,
      builder: (context, state) {
        if (state.banners.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            SizedBox(
              height: 180.height,
              child: PageView.builder(
                controller: bloc.bannerPageController,
                itemCount: state.banners.length,
                onPageChanged: (index) {
                  bloc.add(HomeBannerPageChanged(index));
                },
                itemBuilder: (context, index) {
                  final banner = state.banners[index];
                  return BannerCard(
                    banner: banner,
                    onBookNow: () => onBookNow?.call(banner),
                  );
                },
              ),
            ),
            SizedBox(height: 10.height),
            BannerPageIndicator(
              pageCount: state.banners.length,
              currentPage: state.currentBannerIndex,
            ),
          ],
        );
      },
    );
  }
}