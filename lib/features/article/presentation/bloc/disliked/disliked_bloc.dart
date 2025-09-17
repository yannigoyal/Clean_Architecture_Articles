import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_event.dart';
import 'package:clean_architecture_articles/features/article/presentation/bloc/disliked/disliked_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DislikedBloc extends Bloc<DislikedEvent, DislikedState> {
  // For this demo, disliked are read from local datasource via repository.
  // We'll fetch directly using the repository in the page using ArticleRepositoryImpl via sl.
  DislikedBloc() : super(DislikedInitial()) {
    on<LoadDislikedEvent>(_onLoad);
  }

  Future<void> _onLoad(
    LoadDislikedEvent event,
    Emitter<DislikedState> emit,
  ) async {
    emit(DislikedLoading());
    try {
      // repository call will be done in the page for simplicity; emit empty list here
      emit(DislikedLoaded(articles: event.articles ?? []));
    } catch (e) {
      emit(DislikedError(message: e.toString()));
    }
  }
}
