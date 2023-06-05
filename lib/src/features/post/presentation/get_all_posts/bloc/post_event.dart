part of 'post_bloc.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class PostFetchedEvent extends PostEvent {}

class PostAddedEvent extends PostEvent {
  final PostEntity newPost;

  const PostAddedEvent({required this.newPost});

  @override
  List<Object?> get props => [newPost];
}

class PostEditedEvent extends PostEvent {
  final PostEntity newPost;

  const PostEditedEvent({required this.newPost});

  @override
  List<Object?> get props => [newPost];
}

class PostDeletedEvent extends PostEvent {
  final int postId;

  const PostDeletedEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
