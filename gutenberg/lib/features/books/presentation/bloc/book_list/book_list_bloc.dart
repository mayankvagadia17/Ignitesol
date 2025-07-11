import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/features/books/domain/repositories/book_repository.dart';
import 'book_list_event.dart';
import 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final BookRepository bookRepository;
  int _page = 1;
  String _genre = '';
  String? _searchQuery;

  BookListBloc({required this.bookRepository}) : super(BookListInitial()) {
    on<FetchBooks>(_onFetchBooks);
    on<FetchNextPage>(_onFetchNextPage);
  }

  Future<void> _onFetchBooks(
      FetchBooks event,
      Emitter<BookListState> emit,
      ) async {
    emit(BookListLoading());
    _page = 1;
    _genre = event.genre;
    _searchQuery = event.searchQuery;

    try {
      final books = await bookRepository.getBooks(
        genre: _genre,
        searchQuery: _searchQuery,
        page: _page,
      );
      final hasReachedMax = books.isEmpty;
      emit(BookListLoaded(books: books, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(BookListError(message: 'Failed to fetch books: ${e.toString()}'));
    }
  }

  Future<void> _onFetchNextPage(
      FetchNextPage event,
      Emitter<BookListState> emit,
      ) async {
    if (state is BookListLoaded) {
      final currentState = state as BookListLoaded;
      if (currentState.hasReachedMax) return;

      try {
        _page++;
        final newBooks = await bookRepository.getBooks(
          genre: _genre,
          searchQuery: _searchQuery,
          page: _page,
        );

        if (newBooks.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(
            currentState.copyWith(
              books: List.of(currentState.books)..addAll(newBooks),
              hasReachedMax: false,
            ),
          );
        }
      } catch (e) {
        _page--;
      }
    }
  }
}
