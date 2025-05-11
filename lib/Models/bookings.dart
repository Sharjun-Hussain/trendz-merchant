class Bookings {
  final String booking_id;
  final String user_id;
  final List<String> services;
  final String branch_id;
  final String booking_date;
  final String booking_time;
  final String status;
  final String created_at;
  final String updated_at;

  Bookings({
    required this.booking_id,
    required this.user_id,
    required this.services,
    required this.branch_id,
    required this.booking_date,
    required this.booking_time,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Bookings(
      booking_id: data['booking_id'],
      user_id: data['user_id'],
      services: List<String>.from(data['services']),
      branch_id: data['branch_id'],
      booking_date: data['booking_date'],
      booking_time: data['booking_time'],
      status: data['status'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "booking_id": booking_id,
      "user_id": user_id,
      "services": services,
      "branch_id": branch_id,
      "booking_date": booking_date,
      "booking_time": booking_time,
      "status": status,
      "created_at": created_at,
      "updated_at": updated_at,
    };
  }
}
