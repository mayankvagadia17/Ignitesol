import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final List<String> authors;
  final String coverUrl;
  final Map<String, String> formats;

  const Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.coverUrl,
    required this.formats,
  });

  @override
  List<Object?> get props => [id, title, authors, coverUrl, formats];
}
