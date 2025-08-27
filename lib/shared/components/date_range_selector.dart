import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;

  const DateRangeSelector({
    super.key,
    this.startDate,
    this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  Future<void> _pickStartDate(BuildContext context) async {
    final initialDate = startDate ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && (endDate == null || pickedDate.isBefore(endDate!) || pickedDate.isAtSameMomentAs(endDate!))) {
      onStartDateChanged(pickedDate);
    }
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final initialDate = endDate ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && (startDate == null || pickedDate.isAfter(startDate!) || pickedDate.isAtSameMomentAs(startDate!))) {
      onEndDateChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text('Start Date'),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => _pickStartDate(context),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                startDate != null
                    ? DateFormat('yyyy-MM-dd').format(startDate!)
                    : 'Select start date',
                style: TextStyle(
                    color: startDate != null
                        ? Colors.black87
                        : Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('End Date'),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => _pickEndDate(context),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                endDate != null
                    ? DateFormat('yyyy-MM-dd').format(endDate!)
                    : 'Select end date',
                style: TextStyle(
                    color: endDate != null
                        ? Colors.black87
                        : Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
