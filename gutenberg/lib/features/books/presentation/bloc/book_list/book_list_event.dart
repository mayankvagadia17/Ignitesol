import 'package:equatable/equatable.dart';

abstract class BookListEvent extends Equatable {
  const BookListEvent();

  @override
  List<Object?> get props => [];
}

class FetchBooks extends BookListEvent {
  final String genre;
  final String? searchQuery;

  const FetchBooks({required this.genre, this.searchQuery});

  @override
  List<Object?> get props => [genre, searchQuery];
}

class FetchNextPage extends BookListEvent {}
