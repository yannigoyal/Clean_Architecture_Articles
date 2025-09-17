import 'package:clean_architecture_articles/core/network/news_api_config.dart';
import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/dislike_article.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/get_article.dart';
import 'package:clean_architecture_articles/features/article/domain/usecases/like_article.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetArticlesUseCase getArticles;
  final LikeArticleUseCase likeArticle;
  final DislikeArticleUseCase dislikeArticle;
  final NewsApiConfig config;

  List<Article> _stack = [];

  HomeBloc({
    required this.getArticles,
    required this.likeArticle,
    required this.dislikeArticle,
    required this.config,
  }) : super(HomeInitial()) {
    on<LoadArticlesEvent>(_onLoadArticles);
    on<LikeTopArticleEvent>(_onLikeTop);
    on<DislikeTopArticleEvent>(_onDislikeTop);
  }

  Future<void> _onLoadArticles(
    LoadArticlesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final params = {...config.toMap()};
      if (event.overrideParams != null) params.addAll(event.overrideParams!);
      final articles = await getArticles.call(params: params);
      _stack = articles;
      emit(HomeLoaded(articles: List.of(_stack)));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onLikeTop(
    LikeTopArticleEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_stack.isEmpty) return;
    final top = _stack.removeAt(0);
    await likeArticle.call(top);
    emit(HomeLoaded(articles: List.of(_stack)));
    if (_stack.length < 3) add(LoadArticlesEvent());
  }

  Future<void> _onDislikeTop(
    DislikeTopArticleEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_stack.isEmpty) return;
    final top = _stack.removeAt(0);
    await dislikeArticle.call(top);
    emit(HomeLoaded(articles: List.of(_stack)));
    if (_stack.length < 3) add(LoadArticlesEvent());
  }
}
