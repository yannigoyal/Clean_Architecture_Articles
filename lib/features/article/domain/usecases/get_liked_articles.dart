import '../../domain/entities/article.dart';
import '../repositories/article_repository.dart';

class GetLikedArticlesUseCase {
  final ArticleRepository repository;
  GetLikedArticlesUseCase({required this.repository});

  Future<List<Article>> call() async {
    return await repository.getLikedArticles();
  }
}
