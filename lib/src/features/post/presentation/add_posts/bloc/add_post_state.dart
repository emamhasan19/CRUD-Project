import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

enum AddPostStatus { initial, success, failure, loading }

class AddPostState extends Equatable {
  final AddPostStatus status;
  final PostEntity? post;
  final String errorMessage;

  const AddPostState({
    this.status = AddPostStatus.initial,
    this.post,
    this.errorMessage = "",
  });

  AddPostState copyWith({
    AddPostStatus? status,
    PostEntity? post,
    String? errorMessage,
  }) {
    return AddPostState(
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, post, errorMessage];
}
