// lib/features/home/presentation/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/functions/callback_token.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/core/widgets/app_background.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'widgets/category_item.dart';
import 'widgets/home_profile_widget.dart';
import 'widgets/professional_card.dart';
import 'widgets/promo_banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<String?> _userName;

  @override
  void initState() {
    super.initState();
    _userName = sl<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.fullName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppBackground(
          child: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.loading || state.status == HomeStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == HomeStatus.failure) {
                  return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
                }

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding),
                  children: [
                    SizedBox(height: 8.height),
                    HomeProfileWidget(
                      name: _userName == null ? 'User' : 'User',
                      address: 'London, st12', // TODO: هتيجي من بيانات المستخدم الحقيقية
                      onTap: () {
                        // TODO: الانتقال لشاشة البروفايل
                      },
                      onNotificationTap: () {
                        // TODO: الانتقال لشاشة الإشعارات
                      },
                    ),
                    SizedBox(height: 16.height),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'search plumbers, cleaners...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.tune),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.height),
                    PromoBannerCarousel(
                      onBookNow: (banner) {
                        // TODO: هتوديه فين وقت الضغط على Book now
                      },
                    ),
                    SizedBox(height: 24.height),
                    _SectionHeader(title: 'categorise', onSeeAll: () {}),
                    SizedBox(height: 12.height),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryItem(category: state.categories[index]);
                      },
                    ),
                    SizedBox(height: 24.height),
                    _SectionHeader(title: 'Nearby professionals', onSeeAll: () {}),
                    SizedBox(height: 12.height),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.professionals.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.height),
                      itemBuilder: (context, index) {
                        return ProfessionalCard(professional: state.professionals[index]);
                      },
                    ),
                    SizedBox(height: 20.height),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.responsiveFontScale(15),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See All',
            style: TextStyle(
              color: const Color(0xFF358BE0),
              fontSize: context.responsiveFontScale(13),
            ),
          ),
        ),
      ],
    );
  }
}
