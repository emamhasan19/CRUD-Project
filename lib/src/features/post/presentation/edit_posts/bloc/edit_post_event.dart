import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

abstract class EditPostEvent extends Equatable {
  const EditPostEvent();

  @override
  List<Object> get props => [];
}

class EditPostButtonPressed extends EditPostEvent {
  final PostEntity updatedPost;

  const EditPostButtonPressed(this.updatedPost);

  @override
  List<Object> get props => [updatedPost];
}
