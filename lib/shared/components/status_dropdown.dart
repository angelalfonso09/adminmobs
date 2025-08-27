import 'package:flutter/material.dart';

class StatusDropdown extends StatelessWidget {
  final List<String> statuses;
  final String selectedStatus;
  final Function(String?) onChanged;

  const StatusDropdown({
    super.key,
    required this.statuses,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedStatus,
          items: statuses
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
