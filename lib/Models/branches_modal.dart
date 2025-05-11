class Branches {
  final String branch_name;
  final int code;
  final String address;
  final String phone_number;
  final String email;
  final String location;

  Branches({
    required this.branch_name,
    required this.code,
    required this.phone_number,
    required this.email,
    required this.location,
    required this.address,
  });

  factory Branches.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Branches(
      code: data['id'],
      branch_name: data['category'],
      address: data['description'],
      phone_number: data['duration'],
      email: data['imageUrl'],
      location: data['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "branch_name": branch_name,
      "address": address,
      "phone_number": phone_number,
      "email": email,
      "location": location,
    };
  }
}
