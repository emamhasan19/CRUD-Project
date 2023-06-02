import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_details/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/add_posts/bloc/add_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/edit_posts/bloc/edit_post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/bloc/post_bloc.dart';
import 'package:flutter_details/src/features/post/presentation/get_all_posts/pages/post_page.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/create_post_use_case.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/get_all_posts_use_case.dart';
import 'package:flutter_details/src/features/post/root/domain/use_cases/update_post_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        // BlocProvider(
        //     create: (_) => PostBloc(
        //         getAllPosts: GetAllPosts(),
        //         addPostBloc: AddPostBloc(addPostUseCase: AddPostUseCase()))),
        BlocProvider(
          create: (_) => PostBloc(
            getAllPosts: GetAllPosts(),
          ),
        ),
        BlocProvider(
          create: (_) => AddPostBloc(
            addPostUseCase: AddPostUseCase(),
            context: context,
          ),
        ),
        BlocProvider(
          create: (_) => EditPostBloc(
            editPostUseCase: EditPostUseCase(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostPage(),
      ),
    );
  }
}
