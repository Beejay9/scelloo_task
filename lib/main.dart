import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scelloo_task/app/screens/home_screen.dart';
import 'package:scelloo_task/blocs/posts/post_bloc.dart';
import 'package:scelloo_task/repositories/post_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scelloo Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.deepPurple,
        // ),
        useMaterial3: true,
      ),
      home: BlocProvider<PostBloc>(
        create: (context) => PostBloc(PostRepository()),
        child: const HomeScreen(),
      ),
    );
  }
}
