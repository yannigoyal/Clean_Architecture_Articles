import 'dart:convert';
import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String id,
    required String title,
    String? description,
    String? imageUrl,
    DateTime? publishedAt,
  }) : super(
         id: id,
         title: title,
         description: description,
         imageUrl: imageUrl,
         publishedAt: publishedAt,
       );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String? ?? json['id'] ?? '';
    return ArticleModel(
      id: url,
      title: json['title'] ?? 'No title',
      description: json['description'],
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt?.toIso8601String(),
    };
  }

  String toRawJson() => json.encode(toJson());
  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(json.decode(str));
}
