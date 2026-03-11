import 'package:flutter/material.dart';

import '../../data/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onClear,
    required this.searchController,
    this.onChanged,
    required this.isSearchQueryNotEmpty,
  });

  final Function()? onClear;
  final TextEditingController searchController;
  final Function(String)? onChanged;
  final bool isSearchQueryNotEmpty;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, size: 16),
        filled: true,
        fillColor: AppColors.appBarBack,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: isSearchQueryNotEmpty
            ? IconButton(icon: const Icon(Icons.clear, size: 16), onPressed: onClear)
            : null,
      ),
    );
  }
}
