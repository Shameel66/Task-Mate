import 'package:flutter/material.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTypography.kRegular16,
      decoration: InputDecoration(
          hintText: 'Search Task Here',
          prefixIcon: const Icon(Icons.search),
          hintStyle: AppTypography.kLight14),
    );
  }
}
