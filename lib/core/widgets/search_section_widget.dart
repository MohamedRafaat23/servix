// import 'package:flutter/material.dart';
// import '../../config/router/app_routes_names.dart';
// import '../utils/functions/router_handler.dart';
// import 'image_item.dart';
// import '../utils/constants/app_colors.dart';
// import '../utils/constants/app_images.dart';
// import '../utils/constants/app_strings.dart';
// import 'app_button.dart';
// import '../utils/functions/responsive.dart';

// class SearchSectionWidget extends StatelessWidget {
//   final void Function(String)? onChanged;
//   final void Function()? onSearch;
//   final TextEditingController? controller;
//   final String? hintText;
//   final bool isMainSearch;

//   const SearchSectionWidget({
//     super.key,
//     this.onChanged,
//     this.onSearch,
//     this.controller,
//     this.hintText,
//     this.isMainSearch = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 50.height,
//             padding: EdgeInsets.symmetric(horizontal: 16.width),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadiusDirectional.only(
//                 topStart: Radius.circular(25.radius),
//                 bottomStart: Radius.circular(25.radius),
//                 topEnd: Radius.circular(8.radius),
//                 bottomEnd: Radius.circular(8.radius),
//               ),
//               border: Border.all(color: AppColors.borderGrayColor, width: 1),
//             ),
//             child: Row(
//               children: [
//                 ImageItem(AppImages.search, width: 20.width, height: 20.width),
//                 SizedBox(width: 12.width),
//                 Expanded(
//                   child: TextField(
//                     onTap: isMainSearch
//                         ? null
//                         : () {
//                             RouterHandler.navigate(
//                               context,
//                               AppRoutesNames.search,
//                             );
//                           },
//                     readOnly: !isMainSearch,
//                     controller: controller,
//                     onChanged: onChanged,
//                     onSubmitted: (_) => onSearch?.call(),
//                     decoration: InputDecoration(
//                       hintText: hintText ?? AppStrings.searchHint,
//                       hintStyle: TextStyle(
//                         fontSize: context.responsiveFontScale(14),
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.greyColor,
//                       ),
//                       border: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(width: 10.width),
//         SizedBox(
//           height: 50.height,
//           child: AppButton(
//             text: AppStrings.search,
//             onTap: isMainSearch
//                 ? onSearch
//                 : () {
//                     RouterHandler.navigate(context, AppRoutesNames.search);
//                   },
//             textSize: 14,
//             btnPadding: EdgeInsets.symmetric(horizontal: 24.width),
//             customBorderRadius: BorderRadiusDirectional.only(
//               topStart: Radius.circular(8.radius),
//               bottomStart: Radius.circular(8.radius),
//               topEnd: Radius.circular(25.radius),
//               bottomEnd: Radius.circular(25.radius),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
