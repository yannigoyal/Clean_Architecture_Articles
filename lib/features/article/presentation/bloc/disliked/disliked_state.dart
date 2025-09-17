import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class DislikedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DislikedInitial extends DislikedState {}

class DislikedLoading extends DislikedState {}

class DislikedLoaded extends DislikedState {
  final List<Article> articles;
  DislikedLoaded({required this.articles});
  @override
  List<Object?> get props => [articles];
}

class DislikedError extends DislikedState {
  final String message;
  DislikedError({required this.message});
  @override
  List<Object?> get props => [message];
}
