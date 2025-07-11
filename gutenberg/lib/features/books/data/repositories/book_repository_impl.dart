import 'package:gutenberg/core/error/exceptions.dart';
import 'package:gutenberg/features/books/data/datasources/book_remote_data_source.dart';
import 'package:gutenberg/features/books/domain/entities/book.dart';
import 'package:gutenberg/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Book>> getBooks({
    required String genre,
    String? searchQuery,
    required int page,
  }) async {
    try {
      final bookModels = await remoteDataSource.getBooks(
        genre: genre,
        searchQuery: searchQuery,
        page: page,
      );
      return bookModels;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: 'An unexpected error occurred.');
    }
  }
}
