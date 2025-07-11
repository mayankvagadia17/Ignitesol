import '../entities/book.dart';

abstract class BookRepository {

  Future<List<Book>> getBooks({
    required String genre,
    String? searchQuery,
    required int page,
  });
}
