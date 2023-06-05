// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/core/colors.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class EditPostPage extends StatefulWidget {
  final PostEntity post;

  const EditPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
    _bodyController.text = widget.post.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary_color,
        title: const Text('Edit Post'),
        centerTitle: true,
      ),
      body: BlocConsumer<EditPostBloc, EditPostState>(
        listener: (context, state) {
          if (state.status == EditPostStatus.success) {
            context.read<PostBloc>().add(PostEditedEvent(newPost: state.post!));
            // Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.status == EditPostStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == EditPostStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.primary_color,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Palette.primary_color,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  maxLines: null,
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Body',
                    labelStyle: TextStyle(
                      color: Palette.primary_color,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.primary_color),
                  ),
                  onPressed: () {
                    final title = _titleController.text;
                    final body = _bodyController.text;
                    final updatedPost = PostEntity(
                      userId: widget.post.userId,
                      id: widget.post.id,
                      title: title,
                      body: body,
                    );

                    BlocProvider.of<EditPostBloc>(context)
                        .add(EditPostButtonPressed(updatedPost));
                    //Navigator.pop(context);
                  },
                  child: const Text('Edit Post'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
