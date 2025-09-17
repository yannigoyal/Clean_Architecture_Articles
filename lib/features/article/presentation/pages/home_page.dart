import 'dart:math';
import 'package:clean_architecture_articles/injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_bloc.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/home/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(LoadArticlesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Swipe'),
          actions: [
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () => Navigator.pushNamed(context, '/liked'),
            ),
            IconButton(
              icon: const Icon(Icons.thumb_down),
              onPressed: () => Navigator.pushNamed(context, '/disliked'),
            ),
          ],
        ),
        body: const SafeArea(child: _HomeBody()),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is HomeLoaded) {
          final articles = state.articles;
          if (articles.isEmpty) {
            return const Center(child: Text('No more articles'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final bottomInfoHeight = 140.0;
              final cardWidth = constraints.maxWidth * 0.9;
              final cardHeight = constraints.maxHeight - bottomInfoHeight - 40;

              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: articles
                          .take(6)
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                            final idx = entry.key;
                            final article = entry.value;
                            final topIndex = idx == 0;
                            final positionOffset = min(idx * 8.0, 48.0);

                            return Positioned(
                              top: 20.0 + positionOffset,
                              child: DraggableCard(
                                article: article,
                                isTop: topIndex,
                                width: cardWidth,
                                height: cardHeight,
                                onSwipeLeft: () => context.read<HomeBloc>().add(
                                  DislikeTopArticleEvent(),
                                ),
                                onSwipeRight: () => context
                                    .read<HomeBloc>()
                                    .add(LikeTopArticleEvent()),
                              ),
                            );
                          })
                          .toList()
                          .reversed
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class DraggableCard extends StatelessWidget {
  final Article article;
  final bool isTop;
  final double width;
  final double height;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const DraggableCard({
    super.key,
    required this.article,
    required this.isTop,
    required this.width,
    required this.height,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Article>(
      data: article,
      feedback: _buildCard(article, isDragging: true),
      childWhenDragging: Container(), // hides card when dragging
      onDragEnd: (details) {
        if (!isTop) return;

        final dx = details.offset.dx;
        if (dx > 100) {
          onSwipeRight();
        } else if (dx < -100) {
          onSwipeLeft();
        }
      },
      child: _buildCard(article),
    );
  }

  Widget _buildCard(Article article, {bool isDragging = false}) {
    return Card(
      elevation: isDragging ? 12 : 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Expanded(
              child: article.imageUrl != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        article.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : Container(color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
