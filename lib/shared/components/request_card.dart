import 'package:flutter/material.dart';
import '../../features/requests/models/request.dart';

class RequestCard extends StatelessWidget {
	final Request request;
	const RequestCard({super.key, required this.request});

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(12),
				boxShadow: [
					BoxShadow(
						color: Colors.grey.withOpacity(0.1),
						spreadRadius: 1,
						blurRadius: 4,
						offset: const Offset(0, 2),
					),
				],
			),
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						// Header Row with Name and Status
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								Text(
									request.requester,
									style: const TextStyle(
										fontSize: 16,
										fontWeight: FontWeight.w600,
										color: Colors.black87,
									),
								),
								_buildStatusBadge(),
							],
						),
						const SizedBox(height: 4),
            
						// Request ID
						Text(
							'Request ID: ${request.id}',
							style: TextStyle(
								fontSize: 12,
								color: Colors.grey[600],
							),
						),
						const SizedBox(height: 8),
            
						// Equipment Type Label
						const Text(
							'Equipment Type',
							style: TextStyle(
								fontSize: 12,
								fontWeight: FontWeight.w500,
								color: Colors.black54,
							),
						),
						const SizedBox(height: 4),
            
						// Equipment Type Value
						Text(
							request.equipmentType,
							style: const TextStyle(
								fontSize: 14,
								fontWeight: FontWeight.w500,
								color: Colors.black87,
							),
						),
						const SizedBox(height: 12),
            
						// Quantity and Date Row
						Row(
							children: [
								Expanded(
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											const Text(
												'Quantity',
												style: TextStyle(
													fontSize: 12,
													fontWeight: FontWeight.w500,
													color: Colors.black54,
												),
											),
											const SizedBox(height: 4),
											Text(
												'${request.quantity}',
												style: const TextStyle(
													fontSize: 14,
													fontWeight: FontWeight.w500,
													color: Colors.black87,
												),
											),
										],
									),
								),
								Expanded(
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											const Text(
												'Date',
												style: TextStyle(
													fontSize: 12,
													fontWeight: FontWeight.w500,
													color: Colors.black54,
												),
											),
											const SizedBox(height: 4),
											Text(
												request.date,
												style: const TextStyle(
													fontSize: 14,
													fontWeight: FontWeight.w500,
													color: Colors.black87,
												),
											),
										],
									),
								),
							],
						),
						const SizedBox(height: 12),
            
						// Arrow Button
						Align(
							alignment: Alignment.centerRight,
							child: Container(
								padding: const EdgeInsets.all(8),
								decoration: BoxDecoration(
									color: Colors.grey[100],
									borderRadius: BorderRadius.circular(20),
								),
								child: const Icon(
									Icons.arrow_forward,
									size: 16,
									color: Colors.black54,
								),
							),
						),
					],
				),
			),
		);
	}

	Widget _buildStatusBadge() {
		Color backgroundColor;
		Color textColor;
		String statusText;

		switch (request.status.toLowerCase()) {
			case 'approved':
				backgroundColor = Colors.green[100]!;
				textColor = Colors.green[700]!;
				statusText = 'Approved';
				break;
			case 'rejected':
				backgroundColor = Colors.red[100]!;
				textColor = Colors.red[700]!;
				statusText = 'Rejected';
				break;
			case 'pending':
				backgroundColor = Colors.orange[100]!;
				textColor = Colors.orange[700]!;
				statusText = 'Pending';
				break;
			default:
				backgroundColor = Colors.grey[100]!;
				textColor = Colors.grey[700]!;
				statusText = request.status;
		}

		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
			decoration: BoxDecoration(
				color: backgroundColor,
				borderRadius: BorderRadius.circular(16),
			),
			child: Text(
				statusText,
				style: TextStyle(
					fontSize: 12,
					fontWeight: FontWeight.w600,
					color: textColor,
				),
			),
		);
	}
}
// This file was renamed from request_card_clean.dart to request_card.dart to fix import errors.
// ...existing code from request_card_clean.dart will be placed here...
