import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_bloc.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_state.dart';
import 'package:clean_architecture_articles/features/article/presentation/widgets/article_row.dart';
import 'package:clean_architecture_articles/injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DislikedPage extends StatelessWidget {
  const DislikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DislikedBloc>()..add(LoadDislikedEvent()),

      child: Scaffold(
        appBar: AppBar(title: const Text('Disliked Articles')),
        body: const SafeArea(child: _DislikedBody()),
      ),
    );
  }
}

class _DislikedBody extends StatelessWidget {
  const _DislikedBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DislikedBloc, DislikedState>(
      builder: (context, state) {
        if (state is DislikedLoading || state is DislikedInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DislikedError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is DislikedLoaded) {
          final articles = state.articles;
          if (articles.isEmpty) {
            return const Center(child: Text('No disliked articles yet.'));
          }

          final screenHeight = MediaQuery.of(context).size.height;
          final appBarHeight = kToolbarHeight;
          final padding = MediaQuery.of(context).padding;
          final available =
              screenHeight - appBarHeight - padding.top - padding.bottom;
          final itemHeight = (available / 4).floorToDouble();

          return ListView.separated(
            itemCount: articles.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return SizedBox(
                height: itemHeight,
                child: ArticleRow(article: articles[index]),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
