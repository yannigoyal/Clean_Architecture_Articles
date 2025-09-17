import 'package:clean_architecture_articles/features/article/domain/usecases/get_liked_articles.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/liked/liked_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/liked/liked_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  final GetLikedArticlesUseCase getLikedArticles;
  LikedBloc({required this.getLikedArticles}) : super(LikedInitial()) {
    on<LoadLikedEvent>(_onLoadLiked);
  }

  Future<void> _onLoadLiked(
    LoadLikedEvent event,
    Emitter<LikedState> emit,
  ) async {
    emit(LikedLoading());
    try {
      final list = await getLikedArticles.call();
      emit(LikedLoaded(articles: list));
    } catch (e) {
      emit(LikedError(message: e.toString()));
    }
  }
}
