// profilUser/models/user_profile.dart
class UserProfile {
  final String username;
  String nama;
  String role;
  String tanggalLahir;
  String description;

  UserProfile({
    required this.username,
    required this.nama,
    required this.role,
    required this.tanggalLahir,
    required this.description,
    // Tambahkan bidang lain sesuai kebutuhan
  });
}
