// lib/features/home/presentation/view/widgets/home_profile_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servix/config/app_controller/app_controller_bloc.dart';
import 'package:servix/core/utils/constants/app_images.dart';
import 'package:servix/core/utils/functions/responsive.dart';

// TODO: بدّلها بـ Entity حقيقي (UserProfileEntity) لما feature البروفايل تتعمل
class HomeProfileWidget extends StatelessWidget {
  final String name;
  final String address;
  final String? profilePic;
  final VoidCallback onTap;
  final VoidCallback onNotificationTap;

  const HomeProfileWidget({
    super.key,
    required this.name,
    required this.address,
    this.profilePic,
    required this.onTap,
    required this.onNotificationTap,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.width,
                  backgroundColor: colorScheme.primary.withValues(alpha: .12),
                  backgroundImage: (profilePic?.isNotEmpty ?? false)
                      ? NetworkImage(profilePic!)
                      : null,
                  child: (profilePic?.isEmpty ?? true)
                      ? Icon(
                          Icons.person_rounded,
                          color: colorScheme.primary,
                          size: 22.width,
                        )
                      : null,
                ),
                SizedBox(width: 10.width),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getGreeting()}, $name',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(15),
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 2.height),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: colorScheme.onSurface.withValues(alpha: .65),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                color: colorScheme.onSurface.withValues(alpha: .65),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.width),
        BlocBuilder<AppControllerBloc, AppControllerState>(
          buildWhen: (previous, current) =>
              previous.notificationsCount != current.notificationsCount,
          builder: (context, state) {
            return GestureDetector(
              onTap: onNotificationTap,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.width),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppImages.notification,
                      color: colorScheme.primary,
                    ),
                  ),
                  if (state.notificationsCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          state.notificationsCount > 9
                              ? '9+'
                              : '${state.notificationsCount}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
