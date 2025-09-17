import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LikedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LikedInitial extends LikedState {}

class LikedLoading extends LikedState {}

class LikedLoaded extends LikedState {
  final List<Article> articles;
  LikedLoaded({required this.articles});
  @override
  List<Object?> get props => [articles];
}

class LikedError extends LikedState {
  final String message;
  LikedError({required this.message});
  @override
  List<Object?> get props => [message];
}
