import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class SheetInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const SheetInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
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
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: const Color(0xFFB0BEC5),
            ),
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
        ),
      ],
    );
  }
}