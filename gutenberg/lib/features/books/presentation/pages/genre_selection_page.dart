import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/core/theme/app_colors.dart';
import 'package:gutenberg/core/utils/constants.dart';
import 'package:gutenberg/features/books/presentation/pages/book_list_page.dart';
import 'package:gutenberg/features/books/presentation/widgets/genre_button.dart';
import 'package:gutenberg/features/books/presentation/widgets/top_background.dart';
import '../bloc/genre/genre_cubit.dart';
import '../bloc/genre/genre_state.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_event.dart';
import 'package:gutenberg/core/di/injection_container.dart';

class GenreSelectionPage extends StatefulWidget {
  const GenreSelectionPage({super.key});

  @override
  State<GenreSelectionPage> createState() => _GenreSelectionPageState();
}

class _GenreSelectionPageState extends State<GenreSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: BlocProvider(
        create: (context) => GenreCubit()..getGenres(),
        child: Stack(
          children: [
            const TopBackground(),
            SafeArea(
              child: isWide
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 350,
                        vertical: 100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: Text(
                              'Gutenberg Project',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    fontSize: 70,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: Text(
                              'A social cataloging website that allows you to freely search its database of books, annotations,\nand reviews.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 100),
                          Expanded(
                            child: BlocBuilder<GenreCubit, GenreState>(
                              builder: (context, state) {
                                if (state is GenreLoading ||
                                    state is GenreInitial) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GenreLoaded) {
                                  return GridView.builder(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 70,
                                          mainAxisSpacing: 35,
                                          childAspectRatio: 10,
                                        ),
                                    itemCount: state.genres.length,
                                    itemBuilder: (context, index) {
                                      final genre = state.genres[index];
                                      return GenreButton(
                                        genre: genre,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                create: (context) =>
                                                    sl<BookListBloc>()..add(
                                                      FetchBooks(
                                                        genre: genre.name,
                                                      ),
                                                    ),
                                                child: BookListPage(
                                                  genre: genre.name,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else if (state is GenreError) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text("An unexpected error occurred."),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Gutenberg\nProject',
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  fontSize: 50,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'A social cataloging website that allows you to freely search its database of books, annotations, and reviews.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: BlocBuilder<GenreCubit, GenreState>(
                              builder: (context, state) {
                                if (state is GenreLoading ||
                                    state is GenreInitial) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GenreLoaded) {
                                  return GridView.builder(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: 8,
                                        ),
                                    itemCount: state.genres.length,
                                    itemBuilder: (context, index) {
                                      final genre = state.genres[index];
                                      return GenreButton(
                                        genre: genre,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                create: (context) =>
                                                    sl<BookListBloc>()..add(
                                                      FetchBooks(
                                                        genre: genre.name,
                                                      ),
                                                    ),
                                                child: BookListPage(
                                                  genre: genre.name,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else if (state is GenreError) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text("An unexpected error occurred."),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
