import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/widgets/add_post_sheet.dart';
import 'package:scelloo_task/app/widgets/custom_texts.dart';
import 'package:scelloo_task/app/widgets/post_card.dart';
import 'package:scelloo_task/blocs/posts/post_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(FetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: mediumText(
          'Gt Posts',
          textColor: AppColor.whiteTextColor,
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                backgroundColor: Colors.green,
                content: mediumText(
                  'Your operation was successful',
                  textColor: Colors.white,
                  fontSize: 15,
                ),
              ),
            );
          }

          if (state is PostFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                backgroundColor: Colors.red,
                content: mediumText(
                  'Your operation failed. Please try again',
                  textColor: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.whiteTextColor,
              ),
            );
          }
          if (state is PostFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  mediumText(
                    'Oops! Something went wrong',
                    textColor: AppColor.whiteTextColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PostBloc>().add(FetchPosts());
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppColor.bisqueColor,
                        foregroundColor: AppColor.mainTextColor,
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        )),
                    child: buttonText('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is PostSuccess) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) => PostCard(
                      post: state.posts[index],
                      posterName:
                          state.posts[index].userId == 1 ? 'You' : 'John Doe',
                      posts: state.posts,
                      onTap: () {
                        debugPrint('button clicked');
                        context.read<PostBloc>().add(
                              DeletePost(
                                postId: state.posts[index].newPostId ??
                                    state.posts[index].id!,
                                posts: state.posts,
                              ),
                            );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          builder: (context) => AddPostSheet(),
                        );
                        if (result != null) {
                          debugPrint('pop result is $result');
                          context.read<PostBloc>().add(
                                AddPost(
                                  body: result,
                                  posts: state.posts,
                                ),
                              );
                        }
                      },
                      shape: const CircleBorder(),
                      elevation: 10,
                      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
                      foregroundColor: AppColor.whiteColor,
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
