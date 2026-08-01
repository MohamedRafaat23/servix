import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';

class AppSearchableDropdown<T> extends StatelessWidget {
  const AppSearchableDropdown({
    super.key,
    this.title,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    this.hintText = "",
    this.isEnabled = true,
    this.itemAsString,
    this.compareFn,
  });

  final String? title;
  final T? selectedItem;
  final String hintText;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final bool isEnabled;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextColor,
            ),
          ),
        SizedBox(height: 6.height),
        Container(
          margin: EdgeInsets.only(
            bottom: context.isTablet ? 6.height : 4.height,
          ),
          child: DropdownSearch<T>(
            enabled: isEnabled,
            items: (filter, loadProps) => items.where((item) {
              if (itemAsString != null) {
                return itemAsString!(
                  item,
                ).toLowerCase().contains(filter.toLowerCase());
              }
              return item.toString().toLowerCase().contains(
                filter.toLowerCase(),
              );
            }).toList(),
            selectedItem: selectedItem,
            itemAsString: itemAsString,
            compareFn: compareFn,

            autoValidateMode: AutovalidateMode.onUserInteraction,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.radius),
                  borderSide: BorderSide(
                    color: AppColors.borderGrayColor.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.radius),
                  borderSide: BorderSide(
                    color: AppColors.borderGrayColor.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.radius),
                  borderSide: const BorderSide(
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.radius),
                  borderSide: BorderSide(
                    color: AppColors.borderGrayColor.withValues(alpha: 0.3),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.lightPrimaryColor,
                  size: 24.radius,
                ),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.radius),
                  ),
                ),
              ),
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(15.radius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
