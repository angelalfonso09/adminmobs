import 'package:flutter/material.dart';

class EntryLogFilterButtons extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const EntryLogFilterButtons({
    Key? key,
    required this.selectedFilter,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          _buildFilterButton('Today'),
          _buildFilterButton('This Week'),
          _buildFilterButton('This Month'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = selectedFilter == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterSelected(label),
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF517690) : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Color(0xFF517690) : Colors.grey.shade300,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
