import 'package:flutter/material.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const SearchField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      style: AppTypography.kRegular16,
      decoration: InputDecoration(
          hintText: 'Search Task Here',
          prefixIcon: const Icon(Icons.search),
          hintStyle: AppTypography.kLight14),
    );
  }
}
