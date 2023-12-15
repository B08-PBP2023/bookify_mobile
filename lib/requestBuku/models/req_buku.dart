class BukuReq {
  BukuReq({
    required this.bookTitle,
    required this.author,
    required this.language,
    required this.numPages,
    required this.publicationDate,
    required this.penerbit,
  });

  String bookTitle;
  String author;
  String language;
  int numPages;
  String publicationDate;
  String penerbit;
}
