import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostButtonPressed extends AddPostEvent {
  final PostEntity newPost;

  const AddPostButtonPressed(this.newPost);

  @override
  List<Object> get props => [newPost];
}
