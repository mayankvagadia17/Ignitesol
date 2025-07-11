import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/features/books/presentation/bloc/genre/Genre.dart';
import 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreInitial());

  void getGenres() {
    emit(GenreLoading());
    try {
      final List<Genre> genres = [
        const Genre(name: 'FICTION', icon: 'assets/svg/Fiction.svg'),
        const Genre(name: 'DRAMA', icon: 'assets/svg/Drama.svg'),
        const Genre(name: 'HUMOR', icon: 'assets/svg/Humour.svg'),
        const Genre(name: 'POLITICS', icon: 'assets/svg/Politics.svg'),
        const Genre(name: 'PHILOSOPHY', icon: 'assets/svg/Philosophy.svg'),
        const Genre(name: 'HISTORY', icon: 'assets/svg/History.svg'),
        const Genre(name: 'ADVENTURE', icon: 'assets/svg/Adventure.svg'),
      ];

      emit(GenreLoaded(genres));
    } catch (e) {
      emit(const GenreError('Failed to load genres.'));
    }
  }
}
