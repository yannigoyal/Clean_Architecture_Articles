import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:flutter/material.dart';

class ArticleRow extends StatelessWidget {
  final Article article;
  const ArticleRow({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: double.infinity,
            color: Colors.grey[300],
            child: article.imageUrl != null
                ? Image.network(article.imageUrl!, fit: BoxFit.cover)
                : Icon(Icons.image, size: 40),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  article.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Text(
                  article.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
