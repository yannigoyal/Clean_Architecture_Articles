import 'package:equatable/equatable.dart';

abstract class LikedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLikedEvent extends LikedEvent {}
