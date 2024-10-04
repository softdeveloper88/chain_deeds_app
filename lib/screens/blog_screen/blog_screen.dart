import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/shimmer_home_screen.dart';
import 'package:chain_deeds_app/model/blog_model/blog_model.dart';
import 'package:chain_deeds_app/screens/blog_screen/bloc/blog_event.dart';
import 'package:chain_deeds_app/screens/blog_screen/blog_details_screen.dart';
import 'package:chain_deeds_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/convert_date_time.dart';
import 'bloc/blog_bloc.dart';
import 'bloc/blog_state.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogBloc blogBloc = BlogBloc();

  @override
  void initState() {
    blogBloc.add(BlogDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          elevation: 0,
          leading: InkWell(
              onTap: () {
                NavigatorService.goBack();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              )),
          title: const Text('Blog',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocBuilder<BlogBloc, BlogState>(
            bloc: blogBloc,
            builder: (BuildContext context, BlogState state) {
              if (state is BlogLoading) {
                return ShimmerHomeScreen();
              } else if (state is BlogSuccess) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('OUR BLOG',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 8),
                      const Text(
                        'Dive into our articles to discover firsthand accounts of how small acts of kindness are making a big difference in the world.From volunteer spotlights to project updates and insightful reflections on the power of compassion, our blog offers a glimpse into the heart of our mission.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            Blogs blog=blogBloc.blogModel?.data?.blogs?[index]??Blogs();
                            print(blog.thumbnail);
                            return Container(
                              height: 50.h,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                // alignment: Alignment.bottomCenter,
                                children: [
                                  Expanded(
                                      child: CustomImageView(
                                     imagePath: blog.thumbnail,
                                    height: 400,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  )),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                formatDate(blog.createdAt??''),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                               Text(
                                                 blog.title??'',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),Text(
                                                 blog.subTitle??'',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: AppColors.customYellow,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BlogDetailsScreen(blogBloc,blog)));
                                          },
                                          child: const Text('Read'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }else if(state is BlogFailure){
                return Text(state.error);
              }
              return Container();
            }));
  }
}
