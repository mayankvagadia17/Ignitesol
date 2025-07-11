import 'package:flutter/material.dart';
import 'package:gutenberg/core/theme/app_colors.dart';

class SearchInputField extends StatelessWidget {
  final Function(String) onSearch;

  const SearchInputField({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSearch,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black26,
        ),
        filled: true,
        fillColor: AppColors.secondary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
    );
  }
}
