import '../../domain/entities/article.dart';
import '../repositories/article_repository.dart';

class GetArticlesUseCase {
  final ArticleRepository repository;
  GetArticlesUseCase({required this.repository});

  Future<List<Article>> call({Map<String, String>? params}) async {
    return await repository.fetchArticles(params: params);
  }
}
