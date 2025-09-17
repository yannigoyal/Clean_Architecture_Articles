import 'dart:convert';

import 'package:clean_architecture_articles/core/network/news_api_config.dart';
import 'package:clean_architecture_articles/features/article/data/models/article_model.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> fetchArticles(Map<String, String> params);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;
  final NewsApiConfig config;
  ArticleRemoteDataSourceImpl({required this.client, required this.config});

  @override
  Future<List<ArticleModel>> fetchArticles(Map<String, String> params) async {
    // Merge default config params with provided params
    final merged = {...config.toMap(), ...params};

    final uri = Uri.https('newsapi.org', '/v2/everything', merged);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final articles = (body['articles'] as List<dynamic>? ?? [])
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to fetch articles: ${response.statusCode}');
    }
  }
}
