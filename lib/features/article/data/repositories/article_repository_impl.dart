import 'package:clean_architecture_articles/features/article/data/datasources/article_local_data_source.dart';
import 'package:clean_architecture_articles/features/article/data/datasources/article_remote_data_source.dart';
import 'package:clean_architecture_articles/features/article/data/models/article_model.dart';
import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:clean_architecture_articles/features/article/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Article>> fetchArticles({Map<String, String>? params}) async {
    final remote = await remoteDataSource.fetchArticles(params ?? {});
    return remote.cast<ArticleModel>().map((m) => m as Article).toList();
  }

  @override
  Future<void> likeArticle(Article article) async {
    final model = ArticleModel(
      id: article.id,
      title: article.title,
      description: article.description,
      imageUrl: article.imageUrl,
      publishedAt: article.publishedAt,
    );
    await localDataSource.saveLikedArticle(model);
  }

  @override
  Future<void> dislikeArticle(Article article) async {
    final model = ArticleModel(
      id: article.id,
      title: article.title,
      description: article.description,
      imageUrl: article.imageUrl,
      publishedAt: article.publishedAt,
    );
    await localDataSource.saveDislikedArticle(model);
  }

  @override
  Future<List<Article>> getLikedArticles() async {
    final list = await localDataSource.getLikedArticles();
    return list.cast<ArticleModel>().map((m) => m as Article).toList();
  }

  @override
  Future<List<Article>> getDislikedArticles() async {
    final list = await localDataSource.getDislikedArticles();
    return list.cast<ArticleModel>().map((m) => m as Article).toList();
  }
}
