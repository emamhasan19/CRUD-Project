// part of 'add_post_bloc.dart';
//
// abstract class AddPostEvent extends Equatable {
//   const AddPostEvent();
// }

// import 'package:equatable/equatable.dart';
// import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';
//
// abstract class AddPostEvent extends Equatable {
//   const AddPostEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AddPostButtonPressed extends AddPostEvent {
//   final PostEntity post;
//
//   const AddPostButtonPressed({required this.post});
//
//   @override
//   List<Object?> get props => [post];
// }

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
