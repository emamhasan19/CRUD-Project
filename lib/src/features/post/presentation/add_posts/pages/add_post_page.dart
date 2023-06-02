// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_event.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_state.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
import 'package:flutter_details/src/features/post/root/domain/entities/post_entity.dart';

// class AddPostPage extends StatefulWidget {
//   const AddPostPage({Key? key}) : super(key: key);
//
//   @override
//   _AddPostPageState createState() => _AddPostPageState();
// }
//
// class _AddPostPageState extends State<AddPostPage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _bodyController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // context.read<AddPostBloc>().add(AddPostButtonPressed(newPost));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Post'),
//       ),
//       body: BlocConsumer<AddPostBloc, AddPostState>(
//         listener: (context, state) {
//           if (state.status == AddPostStatus.success) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Post added successfully!'),
//               ),
//             );
//             Navigator.pop(context);
//           } else if (state.status == AddPostStatus.failure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(
//                     labelText: 'Title',
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _bodyController,
//                   decoration: const InputDecoration(
//                     labelText: 'Body',
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     final title = _titleController.text;
//                     final body = _bodyController.text;
//                     final newPost =
//                         PostEntity(userId: 1, id: 1, title: title, body: body);
//
//                     BlocProvider.of<AddPostBloc>(context)
//                         .add(AddPostButtonPressed(newPost));
//                     // Navigator.pop(context, newPost);
//                   },
//                   // onPressed: () {
//                   //   String title = _titleController.text.trim();
//                   //   String body = _bodyController.text.trim();
//                   //   if (title.isNotEmpty && body.isNotEmpty) {
//                   //     PostEntity newPost = PostEntity(
//                   //       id: 0,
//                   //       title: title,
//                   //       body: body,
//                   //       userId: 1,
//                   //     );
//                   //     Navigator.pop(context, newPost);
//                   //   }
//                   // },
//                   child: const Text('Add Post'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

// class _AddPostPageState extends State<AddPostPage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _bodyController = TextEditingController();
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _bodyController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Post'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _bodyController,
//               decoration: const InputDecoration(
//                 labelText: 'Body',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 final title = _titleController.text;
//                 final body = _bodyController.text;
//                 final newPost = PostEntity(
//                   userId: 1,
//                   id: 0, // Set the ID to 0 or null for the new post
//                   title: title,
//                   body: body,
//                 );
//
//                 BlocProvider.of<AddPostBloc>(context)
//                     .add(AddPostButtonPressed(newPost));
//                 Navigator.pop(context);
//               },
//               child: const Text('Add Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
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
            // Fetch posts again after a new post is added
            context.read<PostBloc>().add(PostFetchedEvent());
            Navigator.pop(context); // Pop the AddPostPage from the stack
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
                    if (title.isNotEmpty && body.isNotEmpty) {
                      PostEntity newPost = PostEntity(
                        userId: 1,
                        id: 0, // Set the ID to 0 or null for the new post
                        title: title,
                        body: body,
                      );

                      BlocProvider.of<AddPostBloc>(context)
                          .add(AddPostButtonPressed(newPost));
                      // Navigator.pop(context, newPost);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please provide required data!!"),
                        ),
                      );
                    }
                  },
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
