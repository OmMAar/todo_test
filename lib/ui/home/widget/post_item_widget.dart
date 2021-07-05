import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/models/post/post_model.dart';

class PostItemWidget extends StatelessWidget {
  final PostModel post;

  const PostItemWidget({required this.post});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        color: AppColors.whiteColor,
        child: ListTile(
          title: Text(
            post.title!,
            style: AppStyles.text17Style.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold
            ),
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
          ),
          subtitle:  Text(
            post.body!,
            style: AppStyles.text14Style.copyWith(
                color: AppColors.blackColor,
            ),

          ),
        ),
      ),
    );
  }
}
