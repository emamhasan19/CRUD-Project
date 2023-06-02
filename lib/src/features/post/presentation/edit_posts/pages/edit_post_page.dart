import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_state.dart';
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
        title: const Text('Edit Post'),
      ),
      body: BlocConsumer<EditPostBloc, EditPostState>(
        listener: (context, state) {
          if (state.status == EditPostStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post edited successfully!'),
              ),
            );
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  maxLines: null,
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Body',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
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
