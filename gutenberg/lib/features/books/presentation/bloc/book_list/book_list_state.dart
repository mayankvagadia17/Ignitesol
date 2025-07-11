import 'package:equatable/equatable.dart';
import 'package:gutenberg/features/books/domain/entities/book.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class BookListInitial extends BookListState {}

class BookListLoading extends BookListState {}

class BookListLoaded extends BookListState {
  final List<Book> books;
  final bool hasReachedMax;

  const BookListLoaded({
    required this.books,
    required this.hasReachedMax,
  });

 BookListLoaded copyWith({
    List<Book>? books,
    bool? hasReachedMax,
  }) {
    return BookListLoaded(
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [books, hasReachedMax];
}

class BookListError extends BookListState {
  final String message;

  const BookListError({required this.message});

  @override
  List<Object> get props => [message];
}
