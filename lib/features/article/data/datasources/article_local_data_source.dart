import 'package:clean_architecture_articles/features/article/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ArticleLocalDataSource {
  Future<void> saveLikedArticle(ArticleModel article);
  Future<void> saveDislikedArticle(ArticleModel article);
  Future<List<ArticleModel>> getLikedArticles();
  Future<List<ArticleModel>> getDislikedArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  static const _likedKey = 'liked_articles_v1';
  static const _dislikedKey = 'disliked_articles_v1';

  final SharedPreferences sharedPreferences;

  ArticleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveLikedArticle(ArticleModel article) async {
    final list = sharedPreferences.getStringList(_likedKey) ?? [];
    // avoid duplicates
    final exists = list.any(
      (e) => ArticleModel.fromRawJson(e).id == article.id,
    );
    if (!exists) {
      list.insert(0, article.toRawJson());
      await sharedPreferences.setStringList(_likedKey, list);
    }
  }

  @override
  Future<void> saveDislikedArticle(ArticleModel article) async {
    final list = sharedPreferences.getStringList(_dislikedKey) ?? [];
    final exists = list.any(
      (e) => ArticleModel.fromRawJson(e).id == article.id,
    );
    if (!exists) {
      list.insert(0, article.toRawJson());
      await sharedPreferences.setStringList(_dislikedKey, list);
    }
  }

  @override
  Future<List<ArticleModel>> getLikedArticles() async {
    final list = sharedPreferences.getStringList(_likedKey) ?? [];
    return list.map((e) => ArticleModel.fromRawJson(e)).toList();
  }

  @override
  Future<List<ArticleModel>> getDislikedArticles() async {
    final list = sharedPreferences.getStringList(_dislikedKey) ?? [];
    return list.map((e) => ArticleModel.fromRawJson(e)).toList();
  }
}
