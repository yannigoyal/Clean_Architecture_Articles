import '../../domain/entities/article.dart';
import '../repositories/article_repository.dart';

class DislikeArticleUseCase {
  final ArticleRepository repository;
  DislikeArticleUseCase({required this.repository});

  Future<void> call(Article article) async {
    await repository.dislikeArticle(article);
  }
}
