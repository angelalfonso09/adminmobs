import 'package:flutter/material.dart';

class RequesterDropdown extends StatelessWidget {
  final List<String> requesters;
  final String? selectedRequester;
  final Function(String?) onChanged;

  const RequesterDropdown({
    Key? key,
    required this.requesters,
    this.selectedRequester,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text('Select a Requester'),
          value: selectedRequester,
          items: requesters
              .map((r) => DropdownMenuItem(
                    child: Text(r),
                    value: r,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
