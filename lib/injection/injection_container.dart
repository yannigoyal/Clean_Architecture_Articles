import 'package:clean_architecture_articles/core/network/news_api_config.dart';
import 'package:clean_architecture_articles/features/article/data/datasources/article_local_data_source.dart';
import 'package:clean_architecture_articles/features/article/data/datasources/article_remote_data_source.dart';
import 'package:clean_architecture_articles/features/article/data/repositories/article_repository_impl.dart';
import 'package:clean_architecture_articles/features/article/domain/repositories/article_repository.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/dislike_article.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/get_article.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/get_liked_articles.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/like_article.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_bloc.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_bloc.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/liked/liked_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  sl.registerLazySingleton(() => http.Client());

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  //! Config (initial API params)
  sl.registerSingleton(
    NewsApiConfig(
      apiKey: '65cb8c8aff0544579e8a4deab4c27598',
      q: 'tcs',
      from: '2025-09-15',
      sortBy: 'publishedAt',
    ),
  );

  //! Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(client: sl(), config: sl()),
  );

  sl.registerLazySingleton<ArticleLocalDataSource>(
    () => ArticleLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Repository
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  //! Usecases
  sl.registerLazySingleton(() => GetArticlesUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikeArticleUseCase(repository: sl()));
  sl.registerLazySingleton(() => DislikeArticleUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLikedArticlesUseCase(repository: sl()));

  //! Blocs
  sl.registerFactory(
    () => HomeBloc(
      getArticles: sl(),
      likeArticle: sl(),
      dislikeArticle: sl(),
      config: sl(),
    ),
  );

  sl.registerFactory(() => LikedBloc(getLikedArticles: sl()));
  sl.registerFactory(() => DislikedBloc());
}
