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
