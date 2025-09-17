import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';

abstract class ArticleRepository {
  /// Fetch articles from remote source using params.
  Future<List<Article>> fetchArticles({Map<String, String>? params});

  /// Persist liked/disliked articles locally
  Future<void> likeArticle(Article article);
  Future<void> dislikeArticle(Article article);
  Future<List<Article>> getLikedArticles();
  Future<List<Article>> getDislikedArticles();
}
