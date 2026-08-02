import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class SheetDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;

  const SheetDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        SizedBox(height: 6.height),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: const Color(0xFFB0BEC5),
            ),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFDDE7F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF368CE1)),
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TextStyle(fontSize: context.responsiveFontScale(13))),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}