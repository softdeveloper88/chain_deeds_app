import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/model/blog_model/blog_model.dart';
import 'package:chain_deeds_app/screens/blog_screen/bloc/blog_bloc.dart';
import 'package:chain_deeds_app/widgets/custom_image_view.dart';
import 'package:chain_deeds_app/widgets/like_dislike_widget.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class BlogDetailsScreen extends StatelessWidget {
  BlogDetailsScreen(this.blogBloc,this.blog, {super.key});
  BlogBloc blogBloc;
  Blogs blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0,
        leading: InkWell(
            onTap: (){
              NavigatorService.goBack();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),

        title: const Text('Blog',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      child: CustomImageView(
                          imagePath: blog.thumbnail,
                        // Replace with the actual image URL
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                     Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        color: Colors.black12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                blog.title??'',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                              child: Text(
                                blog.subTitle??'',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LikeDislikeWidget(
                      dislikeCounter: 861,
                      heartCounter: 122,
                      onTapHeart: () {},
                      onTapDislike: () {},
                      bgColor: Colors.orangeAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      height: 40,
                      onPressed: () {
                        // Implement share button functionality
                      },
                      color: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: const Text(
                        'Share',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Blog Content
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VOLUNTEERING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our mission isn\'t just about giving aid; it\'s about empowering individuals to create positive change in their own unique ways. We foster a culture of compassion and solidarity, where each member contributes their skills, time, and resources to build a better world. Together, we sow seeds of hope and empowerment, knowing that every small act of kindness can make a big impact. Join us in transforming intentions into deeds that inspire lasting change.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Second Image
            ClipRRect(
              child: Image.asset(
                'assets/images/image.jpeg',
                // Replace with the actual image URL
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Blog Content Repeat
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VOLUNTEERING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our mission isn\'t just about giving aid; it\'s about empowering individuals to create positive change in their own unique ways. We foster a culture of compassion and solidarity, where each member contributes their skills, time, and resources to build a better world. Together, we sow seeds of hope and empowerment, knowing that every small act of kindness can make a big impact. Join us in transforming intentions into deeds that inspire lasting change.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
