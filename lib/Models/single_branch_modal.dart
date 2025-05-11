class SingleBranchModal {
  final String branch_name;
  final int code;
  final String address;
  final String phone_number;
  final String email;
  final String location;
  final List<String> services;
  final List<String> users;
  final List<String> bookings;

  SingleBranchModal({
    required this.branch_name,
    required this.code,
    required this.phone_number,
    required this.email,
    required this.location,
    required this.address,
    required this.bookings,
    required this.services,
    required this.users,
  });

  // Factory to parse JSON and map to the model
  factory SingleBranchModal.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return SingleBranchModal(
      code: data['code'] ?? 0,
      branch_name: data['category'] ?? '',
      address: data['description'] ?? '',
      phone_number: data['duration'] ?? '',
      email: data['imageUrl'] ?? '',
      location: data['price'] ?? '',
      bookings: List<String>.from(json['bookings'] ?? []),
      services: List<String>.from(json['services'] ?? []),
      users: List<String>.from(json['users'] ?? []),
    );
  }

  // Convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "branch_name": branch_name,
      "address": address,
      "phone_number": phone_number,
      "email": email,
      "location": location,
      "users": users,
      "bookings": bookings,
      "services": services,
    };
  }
}
