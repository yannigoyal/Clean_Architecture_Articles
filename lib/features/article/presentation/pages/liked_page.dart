import 'package:clean_architecture_articles/features/article/presentation/bloc/liked/liked_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/liked/liked_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection/injection_container.dart';
import '../bloc/liked/liked_bloc.dart';
import '../widgets/article_row.dart';

class LikedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LikedBloc>()..add(LoadLikedEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Liked Articles')),
        body: SafeArea(child: _LikedBody()),
      ),
    );
  }
}

class _LikedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedBloc, LikedState>(
      builder: (context, state) {
        if (state is LikedLoading || state is LikedInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LikedError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is LikedLoaded) {
          final articles = state.articles;
          final screenHeight = MediaQuery.of(context).size.height;
          final appBarHeight = kToolbarHeight;
          final padding = MediaQuery.of(context).padding;
          final available =
              screenHeight - appBarHeight - padding.top - padding.bottom;
          final itemHeight = (available / 4)
              .floorToDouble(); // try to show 4 items at once
          return ListView.separated(
            itemCount: articles.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              return SizedBox(
                height: itemHeight,
                child: ArticleRow(article: articles[index]),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
