// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
// import 'package:flutter_details/src/features/post/root/data/models/post_model.dart';
//
// class AddPostPage extends StatelessWidget {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _bodyController = TextEditingController();
//
//   AddPostPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Post'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: BlocConsumer<AddPostBloc, AddPostState>(
//           listener: (context, state) {
//             if (state is PostSuccess) {
//               // Show success message or navigate to another screen
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                 ),
//               );
//             } else if (state is PostFailure) {
//               // Show error message
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.error),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is PostLoading) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return Column(
//                 children: [
//                   TextField(
//                     controller: _titleController,
//                     decoration: InputDecoration(
//                       labelText: 'Title',
//                     ),
//                   ),
//                   TextField(
//                     controller: _bodyController,
//                     decoration: InputDecoration(
//                       labelText: 'Body',
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       final title = _titleController.text;
//                       final body = _bodyController.text;
//
//                       final post =
//                           PostModel(title: title, body: body, userId: 0, id: 0);
//
//                       context
//                           .read<AddPostBloc>()
//                           .add(AddPostButtonPressed(post: post));
//                     },
//                     child: Text('Add Post'),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<AddPostBloc>().add(AddPostButtonPressed(newPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state.status == AddPostStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post added successfully!'),
              ),
            );
            Navigator.pop(context);
          } else if (state.status == AddPostStatus.failure) {
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
                    final newPost =
                        PostEntity(userId: 1, id: 1, title: title, body: body);

                    BlocProvider.of<AddPostBloc>(context)
                        .add(AddPostButtonPressed(newPost));
                    // Navigator.pop(context, newPost);
                  },
                  // onPressed: () {
                  //   String title = _titleController.text.trim();
                  //   String body = _bodyController.text.trim();
                  //   if (title.isNotEmpty && body.isNotEmpty) {
                  //     PostEntity newPost = PostEntity(
                  //       id: 0,
                  //       title: title,
                  //       body: body,
                  //       userId: 1,
                  //     );
                  //     Navigator.pop(context, newPost);
                  //   }
                  // },
                  child: const Text('Add Post'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
