import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:gutenberg/core/api/api_service.dart';
import 'package:gutenberg/features/books/data/datasources/book_remote_data_source.dart';
import 'package:gutenberg/features/books/data/repositories/book_repository_impl.dart';
import 'package:gutenberg/features/books/domain/repositories/book_repository.dart';
import 'package:gutenberg/features/books/presentation/bloc/book_list/book_list_bloc.dart';
import 'package:gutenberg/features/books/presentation/bloc/genre/genre_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => BookListBloc(bookRepository: sl()));

  sl.registerFactory(() => GenreCubit());
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl(dio: sl()));
  sl.registerLazySingleton(() => Dio());
}
