import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/core/theme/app_colors.dart';
import 'package:gutenberg/core/utils/constants.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_event.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_state.dart';
import 'package:gutenberg/features/books/presentation/widgets/book_card.dart';
import 'package:gutenberg/features/books/presentation/widgets/search_input_field.dart';

class BookListPage extends StatefulWidget {
  final String genre;

  const BookListPage({super.key, required this.genre});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);
    return isWide
        ? Scaffold(
            body: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(250.0, 50, 250, 10),
                    child: Column(
                      children: [
                        AppBar(
                          scrolledUnderElevation: 0.0,
                          title: Text(
                            widget.genre,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                          titleSpacing: 0,
                          iconTheme: IconThemeData(color: AppColors.primary),
                        ),
                        Container(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Builder(
                              builder: (context) {
                                return SearchInputField(
                                  onSearch: (query) {
                                    context.read<BookListBloc>().add(
                                      FetchBooks(
                                        genre: widget.genre,
                                        searchQuery: query,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BookListBloc, BookListState>(
                    builder: (context, state) {
                      switch (state) {
                        case BookListLoading():
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        case BookListLoaded():
                          if (state.books.isEmpty) {
                            return const Center(child: Text('No books found.'));
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 250.0,vertical: 20
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 50.0,
                                    mainAxisSpacing: 12.0,
                                    childAspectRatio: 0.7,
                                  ),
                              controller: _scrollController,
                              itemCount: state.hasReachedMax
                                  ? state.books.length
                                  : state.books.length + 1,
                              itemBuilder: (context, index) {
                                return index >= state.books.length
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text("")),
                                      )
                                    : BookCard(book: state.books[index]);
                              },
                            ),
                          );

                        case BookListError():
                          return Center(child: Text(state.message));

                        default:
                          return const Center(
                            child: Text('Start by searching for a book.'),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              title: Text(
                widget.genre,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              titleSpacing: 0,
              iconTheme: IconThemeData(color: AppColors.primary),
            ),
            body: Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Builder(
                      builder: (context) {
                        return SearchInputField(
                          onSearch: (query) {
                            context.read<BookListBloc>().add(
                              FetchBooks(
                                genre: widget.genre,
                                searchQuery: query,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BookListBloc, BookListState>(
                    builder: (context, state) {
                      switch (state) {
                        case BookListLoading():
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        case BookListLoaded():
                          if (state.books.isEmpty) {
                            return const Center(child: Text('No books found.'));
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0,
                                    childAspectRatio: 0.50,
                                  ),
                              controller: _scrollController,
                              itemCount: state.hasReachedMax
                                  ? state.books.length
                                  : state.books.length + 1,
                              itemBuilder: (context, index) {
                                return index >= state.books.length
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text("")),
                                      )
                                    : BookCard(book: state.books[index]);
                              },
                            ),
                          );

                        case BookListError():
                          return Center(child: Text(state.message));

                        default:
                          return const Center(
                            child: Text('Start by searching for a book.'),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<BookListBloc>().add(FetchNextPage());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
