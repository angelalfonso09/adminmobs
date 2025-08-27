import 'package:flutter/material.dart';
import '../models/request_data.dart';
import 'request_details_modal_search.dart';

class SearchResults extends StatelessWidget {
  final List<Request> requests;
  final String searchQuery;

  const SearchResults({
    super.key,
    required this.requests,
    required this.searchQuery,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF517690);
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              searchQuery.isNotEmpty ? Icons.search_off : Icons.search,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty ? 'No requests found' : 'Enter a request ID to search',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searchQuery.isNotEmpty 
                ? 'Try a different search term or adjust your filters'
                : 'Type a request ID (e.g., 2022-172259) or select a status filter to see results',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.blue.shade50,
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Found ${requests.length} result${requests.length != 1 ? 's' : ''}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return RequestResultCard(request: request);
            },
          ),
        ),
      ],
    );
  }
}

class RequestResultCard extends StatelessWidget {
  final Request request;

  const RequestResultCard({super.key, required this.request});

  void _showRequestDetailsModal(BuildContext context, Request request) {
    RequestDetailsModal.show(context, request);
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF517690);
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    request.requester,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(request.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: getStatusColor(request.status)),
                  ),
                  child: Text(
                    request.status,
                    style: TextStyle(
                      color: getStatusColor(request.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Request details
            _buildClickableDetailRow(context, 'Request ID', request.id, Icons.confirmation_number, request),
            _buildDetailRow('Equipment', request.equipmentType, Icons.devices),
            _buildDetailRow('Quantity', request.quantity.toString(), Icons.format_list_numbered),
            _buildDetailRow('Destination', request.destination, Icons.location_on),
            _buildDetailRow('Purpose', request.purpose, Icons.description),
            _buildDetailRow('Date', request.date, Icons.calendar_today),
            
            const SizedBox(height: 12),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Show details modal
                  _showRequestDetailsModal(context, request);
                },
                icon: const Icon(Icons.visibility),
                label: const Text('View Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF517690),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableDetailRow(BuildContext context, String label, String value, IconData icon, Request request) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          _showRequestDetailsModal(context, request);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF517690)),
              const SizedBox(width: 8),
              Text(
                '$label: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF517690),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Icon(Icons.open_in_new, size: 16, color: Color(0xFF517690)),
            ],
          ),
        ),
      ),
    );
  }
}
