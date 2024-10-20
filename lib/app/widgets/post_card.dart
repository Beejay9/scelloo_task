import 'package:flutter/material.dart';
import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/screens/post_screen.dart';
import 'package:scelloo_task/app/widgets/custom_texts.dart';
import 'package:scelloo_task/models/post.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.posterName,
    required this.posts,
    this.onTap,
  });

  final Post post;
  final String posterName;
  final List<Post> posts;
  final void Function()? onTap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Post? post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostScreen(
              post: post ?? widget.post,
              postColor: AppColor.bisqueColor,
              posts: widget.posts,
            ),
          ),
        );
        if (result != null) {
          post = result;
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColor.bisqueColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(
              post?.title ?? '${widget.post.title}',
              fontSize: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColor.sColor,
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText(
                      'Posted by',
                      textColor: AppColor.subTextColor,
                      fontSize: 12,
                    ),
                    mediumText(
                      widget.posterName,
                      fontSize: 14,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                if (widget.post.userId == 1)
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Icon(Icons.delete),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
