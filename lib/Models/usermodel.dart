class User {
  final String email;
  final int id;
  final int saloon_id;
  final bool status;
  final String name;
  final String image;
  final String token;
  final String phone_number;
  final String saloon_name;
  final String branch;

  User({
    required this.email,
    required this.id,
    required this.token,
    required this.image,
    required this.name,
    required this.saloon_id,
    required this.status,
    required this.phone_number,
    required this.saloon_name,
    required this.branch,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final shop =
        data['shop']; // Fixed to access 'shop' in the correct hierarchy

    return User(
      email: data['email'],
      saloon_id: data['saloon_id'],
      id: data['id'],
      image: data['image'],
      token: json['token'],
      status: data['status'] == 1, // Converts int to bool
      name: data['name'],
      phone_number: shop['phone_number'], // Get phone from 'shop'
      saloon_name: shop['name'], // Saloon name from 'shop'
      branch: shop['address'], // Use address as branch (adjust if needed)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "name": name,
      "token": token,
      "status": status ? 1 : 0, // Convert bool back to int
      "image": image,
      "saloon_id": saloon_id,
      "phone_number": phone_number,
      "saloon_name": saloon_name,
      "branch": branch,
    };
  }
}
