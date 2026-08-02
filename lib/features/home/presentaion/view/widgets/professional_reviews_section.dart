import 'package:flutter/material.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';
import 'package:servix/features/home/domain/entites/review_entity.dart';
import 'review_item_card.dart';
import 'section_header_with_icon.dart';

class ProfessionalReviewsSection extends StatelessWidget {
  final List<ReviewEntity>? reviews;
  final VoidCallback? onSeeAllTap;

  const ProfessionalReviewsSection({
    super.key,
    this.reviews,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultReviews = const [
      ReviewEntity(
        id: '1',
        userName: 'Rana Saeed',
        userImage: AppImages.frame1,
        date: '21/6/2026',
        comment:
            'The explanation style is excellent and very easy to understand, and the information is conveyed',
        rating: 5,
      ),
      ReviewEntity(
        id: '2',
        userName: 'Mahmoud Sami',
        userImage: AppImages.frame2,
        date: '19/6/2026',
        comment:
            'The explanation was excellent and well-organized, and the content was rich with real-life examples',
        rating: 5,
      ),
    ];

    final displayReviews =
        (reviews != null && reviews!.isNotEmpty) ? reviews! : defaultReviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWithIcon(
          icon: Icons.chat_bubble_outline,
          title: 'Reviews',
          actionText: 'See All',
          onActionTap: onSeeAllTap,
        ),
        SizedBox(height: 10.height),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayReviews.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.height),
          itemBuilder: (context, index) {
            final review = displayReviews[index];
            return ReviewItemCard(
              name: review.userName,
              date: review.date,
              imageAsset: review.userImage,
              comment: review.comment,
              rating: review.rating,
            );
          },
        ),
      ],
    );
  }
}
