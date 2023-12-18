// profilUser/models/user_profile.dart
class UserProfile {
  String username;
  String role;
  String tanggalLahir;
  String description;

  UserProfile({
    required this.username,
    required this.role,
    required this.tanggalLahir,
    required this.description,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    username: json["username"],
    role: json["role"],
    tanggalLahir: json["tanggalLahir"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "role": role,
    "tanggalLahir": tanggalLahir,
    "description": description,
  };
}
