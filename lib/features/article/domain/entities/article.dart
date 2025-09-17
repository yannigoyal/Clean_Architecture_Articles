import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id; // we'll use url as id if available
  final String title;
  final String? description;
  final String? imageUrl;
  final DateTime? publishedAt;

  Article({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.publishedAt,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, publishedAt];
}
