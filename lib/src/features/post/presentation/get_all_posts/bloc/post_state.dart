part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.errorMessage = '',
  });

  final PostStatus status;
  final List<PostEntity> posts;
  final String errorMessage;

  PostState copyWith({
    PostStatus? status,
    List<PostEntity>? posts,
    String? errorMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, errorMessage];
}
