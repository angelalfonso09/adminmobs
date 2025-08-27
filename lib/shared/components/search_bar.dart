import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onClear;

  const SearchTextField({
    super.key, 
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        hintText: 'Search Request ID (e.g., 2022-172259)',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty 
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                if (onChanged != null) onChanged!('');
                if (onClear != null) onClear!();
              },
            )
          : null,
      ),
      onChanged: onChanged,
    );
  }
}
