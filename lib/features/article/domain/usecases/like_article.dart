import '../../domain/entities/article.dart';
import '../repositories/article_repository.dart';

class LikeArticleUseCase {
  final ArticleRepository repository;
  LikeArticleUseCase({required this.repository});

  Future<void> call(Article article) async {
    await repository.likeArticle(article);
  }
}
