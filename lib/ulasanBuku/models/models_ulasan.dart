// ulasanBuku/models/model_ulasan.dart
class BookReview {
  final String username;
  String nama;
  String tanggalReview;
  String reviewText;
  String rating;

  BookReview({
    required this.username,
    required this.nama,
    required this.tanggalReview,
    required this.reviewText,
    required this.rating,
    // Tambahkan bidang lain sesuai kebutuhan
  });
}
