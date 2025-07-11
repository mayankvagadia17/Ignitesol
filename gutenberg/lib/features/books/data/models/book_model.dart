import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.authors,
    required super.coverUrl,
    required super.formats,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    List<String> getAuthors(List<dynamic> authorsJson) {
      return authorsJson
          .map((author) => author['name'] as String)
          .toList();
    }

     String getCoverUrl(Map<String, dynamic> formatsJson) {
      return formatsJson['image/jpeg'] ?? '';
    }

    Map<String, String> getFormats(Map<String, dynamic> formatsJson) {
      return formatsJson.map((key, value) => MapEntry(key, value.toString()));
    }


    return BookModel(
      id: json['id'],
      title: json['title'],
      authors: getAuthors(json['authors']),
      coverUrl: getCoverUrl(json['formats']),
      formats: getFormats(json['formats']),
    );
  }
}
