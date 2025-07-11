import 'package:gutenberg/core/api/api_service.dart';
import 'package:gutenberg/core/error/exceptions.dart';
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks({
    required String genre,
    String? searchQuery,
    required int page,
  });
}
class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final ApiService apiService;

  BookRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookModel>> getBooks({
    required String genre,
    String? searchQuery,
    required int page,
  }) async {
    final queryParameters = {
      'page': page,
      'mime_type': 'image',
      'topic': genre.toLowerCase(),
    };
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParameters['search'] = searchQuery;
    }

    try {
      final data = await apiService.get('/books', queryParameters: queryParameters);
      final results = data['results'] as List;
      return results.map((bookJson) => BookModel.fromJson(bookJson)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Failed to parse book data.');
    }
  }
}
