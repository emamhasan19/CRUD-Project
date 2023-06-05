import 'package:equatable/equatable.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

enum EditPostStatus { initial, success, failure, loading }

class EditPostState extends Equatable {
  final EditPostStatus status;
  final PostEntity? post;
  final String errorMessage;

  const EditPostState(
      {this.status = EditPostStatus.initial,
      this.post,
      this.errorMessage = ""});

  EditPostState copyWith({
    EditPostStatus? status,
    PostEntity? post,
    String? errorMessage,
  }) {
    return EditPostState(
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, post, errorMessage];
}
