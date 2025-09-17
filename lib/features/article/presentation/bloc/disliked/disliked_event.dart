import 'package:clean_architecture_articles/features/article/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class DislikedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDislikedEvent extends DislikedEvent {
  final List<Article>? articles;
  LoadDislikedEvent({this.articles});
}
