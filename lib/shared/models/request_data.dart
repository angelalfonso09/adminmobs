class Request {
  final String id;
  final String requester;
  final String status;
  final String equipmentType;
  final int quantity;
  final String date;
  final String destination;
  final String purpose;
  final String submissionDate;
  final String securedBy;

  Request({
    required this.id,
    required this.requester,
    required this.status,
    required this.equipmentType,
    required this.quantity,
    required this.date,
    required this.destination,
    required this.purpose,
    required this.submissionDate,
    required this.securedBy,
  });
}

class RequestData {
  static final List<Request> _allRequests = [
    Request(
      id: '2022-172259',
      requester: 'Maria Santos',
      status: 'Approved',
      equipmentType: 'Laptop (Lenovo ThinkPad)',
      quantity: 1,
      date: '2024-07-20',
      destination: 'ComLab 502',
      purpose: 'Software Development',
      submissionDate: '2024-07-20',
      securedBy: '2024-07-27',
    ),
    Request(
      id: '2022-182347',
      requester: 'James Rodriguez',
      status: 'Pending',
      equipmentType: 'Monitor (Dell 24")',
      quantity: 2,
      date: '2024-07-21',
      destination: 'Office 301',
      purpose: 'Design Work',
      submissionDate: '2024-07-21',
      securedBy: '2024-07-28',
    ),
    Request(
      id: '2023-194562',
      requester: 'Sarah Kim',
      status: 'Rejected',
      equipmentType: 'Keyboard (Mechanical)',
      quantity: 1,
      date: '2024-07-22',
      destination: 'ComLab 501',
      purpose: 'Programming',
      submissionDate: '2024-07-22',
      securedBy: '2024-07-29',
    ),
    Request(
      id: '2023-205681',
      requester: 'Michael Chen',
      status: 'Approved',
      equipmentType: 'Projector (Epson)',
      quantity: 1,
      date: '2024-07-23',
      destination: 'Conference Room A',
      purpose: 'Presentation',
      submissionDate: '2024-07-23',
      securedBy: '2024-07-30',
    ),
    Request(
      id: '2024-217394',
      requester: 'Jessica Thompson',
      status: 'Pending',
      equipmentType: 'Tablet (iPad Pro)',
      quantity: 1,
      date: '2024-07-24',
      destination: 'Mobile Office',
      purpose: 'Field Work',
      submissionDate: '2024-07-24',
      securedBy: '2024-07-31',
    ),
    Request(
      id: '2024-228756',
      requester: 'David Martinez',
      status: 'Approved',
      equipmentType: 'Mouse (Logitech Wireless)',
      quantity: 3,
      date: '2024-07-25',
      destination: 'IT Department',
      purpose: 'Office Setup',
      submissionDate: '2024-07-25',
      securedBy: '2024-08-01',
    ),
    Request(
      id: '2024-239817',
      requester: 'Lisa Anderson',
      status: 'Pending',
      equipmentType: 'Webcam (HD 1080p)',
      quantity: 2,
      date: '2024-07-26',
      destination: 'Meeting Room B',
      purpose: 'Video Conferences',
      submissionDate: '2024-07-26',
      securedBy: '2024-08-02',
    ),
    Request(
      id: '2024-241028',
      requester: 'Robert Garcia',
      status: 'Rejected',
      equipmentType: 'Headphones (Sony)',
      quantity: 1,
      date: '2024-07-27',
      destination: 'Studio Room',
      purpose: 'Audio Recording',
      submissionDate: '2024-07-27',
      securedBy: '2024-08-03',
    ),
  ];

  static Request? getRequestById(String requestId) {
    try {
      return _allRequests.firstWhere(
        (request) => request.id.toUpperCase() == requestId.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static List<Request> searchRequests({
    String? requestId,
    String? requester,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    List<Request> filteredRequests = List.from(_allRequests);

    if (requestId != null && requestId.isNotEmpty) {
      filteredRequests = filteredRequests.where((request) =>
        request.id.toUpperCase().contains(requestId.toUpperCase())
      ).toList();
    }

    if (requester != null && requester.isNotEmpty) {
      filteredRequests = filteredRequests.where((request) =>
        request.requester.toLowerCase().contains(requester.toLowerCase())
      ).toList();
    }

    if (status != null && status.isNotEmpty && status != 'All') {
      filteredRequests = filteredRequests.where((request) =>
        request.status == status
      ).toList();
    }

    if (startDate != null) {
      filteredRequests = filteredRequests.where((request) {
        DateTime requestDate = DateTime.parse(request.date);
        return requestDate.isAfter(startDate.subtract(Duration(days: 1)));
      }).toList();
    }

    if (endDate != null) {
      filteredRequests = filteredRequests.where((request) {
        DateTime requestDate = DateTime.parse(request.date);
        return requestDate.isBefore(endDate.add(Duration(days: 1)));
      }).toList();
    }

    return filteredRequests;
  }

  static List<String> getAllRequesters() {
    return _allRequests.map((request) => request.requester).toSet().toList()..sort();
  }

  static List<String> getAllRequestIds() {
    return _allRequests.map((request) => request.id).toList()..sort();
  }

  static String? getRequesterByRequestId(String requestId) {
    Request? request = getRequestById(requestId);
    return request?.requester;
  }
}
