import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class ProfileDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T selectedItem;
  final Color? color;
  final Function(T?) onChanged;
  final String Function(T) getItemLabel; // Function to extract label from model

  ProfileDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
     this.color=AppColors.backgroundScreenColor,
    required this.getItemLabel, // Add function to extract label
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              value: selectedItem,
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(getItemLabel(item)), // Display label from model
                );
              }).toList(),
              onChanged: (value) => onChanged(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: color ?? const Color(0xFFF3F7FF),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
