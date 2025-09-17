import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadArticlesEvent extends HomeEvent {
  final Map<String, String>? overrideParams;
  LoadArticlesEvent({this.overrideParams});
}

class LikeTopArticleEvent extends HomeEvent {}

class DislikeTopArticleEvent extends HomeEvent {}
