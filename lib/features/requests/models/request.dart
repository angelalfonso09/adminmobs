class Request {
  final String id;
  final String requester;
  final String status;
  final String equipmentType;
  final int quantity;
  final String date;

  Request({
    required this.id,
    required this.requester,
    required this.status,
    required this.equipmentType,
    required this.quantity,
    required this.date,
  });
}
