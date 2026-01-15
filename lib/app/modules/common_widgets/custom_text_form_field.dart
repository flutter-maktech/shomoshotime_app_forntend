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
        prefixIcon: Icon(Icons.search, size: 16),
        filled: true,
        fillColor: AppColors.appBarBack,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: isSearchQueryNotEmpty
            ? IconButton(icon: Icon(Icons.clear, size: 16), onPressed: onClear)
            : null,
      ),
    );
  }
}
