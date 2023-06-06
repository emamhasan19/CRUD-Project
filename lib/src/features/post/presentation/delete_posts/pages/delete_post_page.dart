// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_details/src/core/colors.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_bloc.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_event.dart';
// import 'package:flutter_details/src/features/post/presentation/delete_posts/bloc/delete_post_state.dart';
// import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
//
// class DeletePostPage extends StatefulWidget {
//   final int postId;
//
//   const DeletePostPage({Key? key, required this.postId}) : super(key: key);
//
//   @override
//   State<DeletePostPage> createState() => _DeletePostPageState();
// }
//
// class _DeletePostPageState extends State<DeletePostPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Palette.primary_color,
//         title: const Text('Delete Post'),
//         centerTitle: true,
//       ),
//       body: BlocConsumer<DeletePostBloc, DeletePostState>(
//         listener: (context, state) {
//           if (state.status == DeletePostStatus.success) {
//             context
//                 .read<PostBloc>()
//                 .add(PostDeletedEvent(postId: widget.postId));
//
//             Navigator.pop(context);
//           } else if (state.status == DeletePostStatus.failure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Are you sure you want to delete this post?',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Palette.primary_color),
//                   ),
//                   onPressed: () {
//                     BlocProvider.of<DeletePostBloc>(context)
//                         .add(PostDeleteRequested(widget.postId));
//                     // deletePostBloc.add(PostDeleteRequested(postId: postId));
//                     // Navigator.pop(context);
//                   },
//                   child: const Text(
//                     'Delete',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
