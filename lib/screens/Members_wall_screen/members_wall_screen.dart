import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/common_shimmer_loading.dart';
import 'package:chain_deeds_app/model/member_wall_model/member_message_model.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/add_comaign_idea_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../widgets/like_dislike_widget.dart';
import '../blog_screen/add_blog_post_screen.dart';
import 'bloc/member_bloc.dart';
import 'bloc/member_event.dart';
import 'bloc/member_state.dart';

class MembersWallScreen extends StatefulWidget {
  @override
  State<MembersWallScreen> createState() => _MembersWallScreenState();
}

class _MembersWallScreenState extends State<MembersWallScreen> {
  MemberBloc memberBloc = MemberBloc();

  // final ScrollController _scrollController = ScrollController();
  TextEditingController messageEditingController = TextEditingController();

  @override
  void initState() {
    memberBloc.add(MemberDataEvent(1));
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     // Trigger LoadMoreData event when reaching the bottom
    //     memberBloc
    //         .add(CheckIfNeedMoreDataEvent(offset: memberBloc.nextPageTrigger));
    //   }
    // });
    super.initState();
  }

  int offset = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          // Ensure title starts at the very left
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 14, color: Colors.black),
                onPressed: () {
                  NavigatorService.goBack();
                  // Handle back button press
                },
                padding: EdgeInsets.zero, // Remove padding from the icon button
                constraints:
                    const BoxConstraints(), // Remove any constraints to make sure it sticks to the edge
              ),
              const Expanded(
                child: Text(
                  'Members Wall',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddBlogPostScreen()));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Post a blog",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCampaignIdeaScreen()));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Member idea's",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<MemberBloc, MemberState>(
            bloc: memberBloc,
            listener: (BuildContext context, MemberState state) {
              if (state is MemberSuccess) {}
            },
            builder: (BuildContext context, MemberState state) {
              if (state is MemberLoading) {
                return const CommonShimmerLoading();
              } else if (state is MemberSuccess) {
                return buildWidget(context, memberBloc.memberMessageModel);
              } else {
                return Container();
              }
            }));
  }

  Stack buildWidget(context, memberData) {
    return Stack(children: [
      Positioned.fill(
        child: SvgPicture.asset(
          'assets/vectors/bg_image.svg',
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    (memberData?.data.messages?.messages.keys.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  if (index ==
                      (memberData?.data.messages?.messages.keys.length ?? 0)) {
                    if (memberBloc.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              offset += 1;
                              memberBloc.add(
                                  CheckIfNeedMoreDataEvent(offset: offset));
                            });
                          },
                          color: Colors.blue,
                          child: const Text(
                            "Load More",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }
                  String date = memberData?.data.messages?.messages.keys
                          .elementAt(index) ??
                      '';
                  List<Message>? messagesForDate = memberBloc
                      .memberMessageModel?.data.messages?.messages[date];

                  return Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              color: AppColors.buttonCustomGray,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            date,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // ...messagesForDate!.map((message) => PostCard(
                      //         memberBloc,
                      //         message.message,
                      //         message.id,
                      //         message.likes,
                      //         message.unlikes,
                      //         message.createdAt, onTapLike: () {
                      //       if (message.isLiked) {
                      //         message.likes--; // Remove the like if already liked
                      //         message.isLiked = false;
                      //       } else {
                      //         message.likes++;
                      //         if (message.isDisliked) {
                      //           message
                      //               .unlikes--; // Remove dislike if it was disliked
                      //           message.isDisliked = false;
                      //         }
                      //         message.isLiked = true;
                      //       }
                      //       memberBloc.add(MembersWallMessageReactionEvent(
                      //           message.id.toString(), 'L'));
                      //       setState(() {});
                      //     }, onTapUnLike: () {
                      //       if (message.isDisliked) {
                      //         message
                      //             .likes--; // Remove the dislike if already disliked
                      //         message.isDisliked = false;
                      //       } else {
                      //         message.likes++;
                      //         if (message.isLiked) {
                      //           message.likes--; // Remove like if it was liked
                      //           message.isLiked = false;
                      //         }
                      //         message.isDisliked = true;
                      //       }
                      //       setState(() {});
                      //       memberBloc.add(MembersWallMessageReactionEvent(
                      //           message.id.toString(), 'D'));
                      //     })),
                      ...messagesForDate!.map((message) => PostCard(
                              memberBloc,
                              message.message,
                              message.id,
                              message.likes,
                              message.unlikes,
                              message.createdAt, onTapLike: () {
                            // Handle like logic
                            if (message.isLiked) {
                              if (message.likes > 0) {
                                message.likes--;
                              } // Remove the like if already liked
                              message.isLiked = false;
                            } else {
                              message.likes++;
                              if (message.isDisliked) {
                                if (message.likes > 0) {
                                  message.likes--;
                                } // Remove dislike if it was disliked
                                message.isDisliked = false;
                              }
                              message.isLiked = true;
                            }
                            // Dispatch your Bloc event for the like action
                            memberBloc.add(MembersWallMessageReactionEvent(
                                message.id.toString(), 'L'));

                            // Update the UI
                            setState(() {});
                          }, onTapUnLike: () {
                            // Handle dislike logic
                            if (message.isDisliked) {
                              if (message.unlikes > 0) {
                                message.unlikes--;
                              } // Remove the dislike if already disliked
                              message.isDisliked = false;
                            } else {
                              message.unlikes++;
                              if (message.isLiked) {
                                if (message.likes > 0) {
                                  message.likes--;
                                } // Remove like if it was liked
                                message.isLiked = false;
                              }
                              message.isDisliked = true;
                            }

                            // Dispatch your Bloc event for the dislike action
                            memberBloc.add(MembersWallMessageReactionEvent(
                                message.id.toString(), 'D'));

                            // Update the UI
                            setState(() {});
                          })),
                    ],
                  );
                }),
          )),
          Container(
            margin: const EdgeInsets.all(4),
            // height: 100,
            decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)
                    // topRight: Radius.circular(20),
                    // topLeft: Radius.circular(20)),
                    )),
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: messageEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Write a message...',
                        border: InputBorder.none,
                        // Removes the underline
                        filled: true,
                        // Optional: Adds a background color
                        fillColor: Colors.white,
                        // Optional: Background color
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file)),
                      TextButton(
                        onPressed: () {
                          memberBloc.add(SendMessageMemberEvent(
                              messageEditingController.text, '', ''));
                          messageEditingController.text = '';
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              border:
                                  Border.all(color: Colors.black12, width: 1)),
                          child: const Text('  Send  '),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ]);
  }
}

class PostCard extends StatefulWidget {
  PostCard(this.memberBloc, this.message, this.id, this.likes, this.unlikes,
      this.createdAt,
      {this.onTapLike, this.onTapUnLike, super.key});

  MemberBloc memberBloc;
  String message;
  int id;
  int likes;
  int unlikes;
  String createdAt;
  Function? onTapLike;
  Function? onTapUnLike;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  widget.message ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              LikeDislikeWidget(
                  heartCounter: widget.likes,
                  dislikeCounter: widget.unlikes,
                  onTapDislike: () => widget.onTapUnLike!(),
                  onTapHeart: () => widget.onTapLike!(),
                  bgColor: Colors.yellow),
              const SizedBox(width: 16.0),
              const Spacer(),
              Text(
                DateFormat('HH:mm:ss').format(DateTime.parse(widget.createdAt)),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
