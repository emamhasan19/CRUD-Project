import 'package:equatable/equatable.dart';

abstract class DeletePostEvent extends Equatable {
  const DeletePostEvent();

  @override
  List<Object?> get props => [];
}

class PostDeleteRequested extends DeletePostEvent {
  final int postId;

  const PostDeleteRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}
