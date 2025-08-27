import 'package:flutter/material.dart';

class RequesterDropdown extends StatelessWidget {
  final List<String> requesters;
  final String? selectedRequester;
  final Function(String?) onChanged;

  const RequesterDropdown({
    super.key,
    required this.requesters,
    this.selectedRequester,
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
          hint: const Text('Select a Requester'),
          value: selectedRequester,
          items: requesters
              .map((r) => DropdownMenuItem(
                    value: r,
                    child: Text(r),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
