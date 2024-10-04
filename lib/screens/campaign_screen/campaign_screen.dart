import 'package:chain_deeds_app/core/convert_hex_color.dart';
import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/shimmer_loader/shimmer_home_screen.dart';
import '../../widgets/mile_stone_card.dart';
import 'bloc/campaign_bloc.dart';
import 'bloc/campaign_event.dart';
import 'bloc/campaign_state.dart';

class CampaignScreen extends StatefulWidget {
  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  CampaignBloc campaignBloc = CampaignBloc();

  @override
  void initState() {
    campaignBloc.add(CampaignDataEvent());
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
          title: const Text('Campaign',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocBuilder<CampaignBloc, CampaignState>(
            bloc: campaignBloc,
            builder: (BuildContext context, CampaignState state) {
              if (state is CampaignLoading) {
                return ShimmerHomeScreen();
              } else if (state is CampaignSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(24.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount Raised',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('\£150,000',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.backgroundCustomLightGray
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(16.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Charity',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('162',
                                  style: TextStyle(
                                      fontSize: 32, color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              state.response.data?.campaigns?.length ?? 0,
                          itemBuilder: (context, index) {
                            return MilestoneCard(
                              onTapDislike: () {
                                campaignBloc.add(CampaignLikeDisLikeEvent(
                                    state.response.data?.campaigns![index].id
                                        ?.toInt() ??
                                        0,
                                    'dislike'));

                                // if (state.response.data?.campaigns![index]
                                //             .isLike ==
                                //         null ||
                                //     state.response.data?.campaigns![index]
                                //             .isLike ==
                                //         0 ||
                                //     state.response.data?.campaigns![index]
                                //             .isLike ==
                                //         1) {
                                //   campaignBloc.add(CampaignLikeDisLikeEvent(
                                //       state.response.data?.campaigns![index].id
                                //           ?.toInt() ??
                                //           0,
                                //       'dislike'));
                                //   if ((state.response.data
                                //               ?.campaigns![index].likes ??
                                //           0) >
                                //       0) {
                                //     state.response.data?.campaigns![index]
                                //         .likes = state.response.data
                                //             ?.campaigns![index].likes ??
                                //         0 - 1;
                                //   }
                                  // state.response.data?.campaigns![index]
                                  //         .unlikes ??
                                  //     0 + 1;
                                // }
                              },
                              onTapHeart: () {
                                campaignBloc.add(CampaignLikeDisLikeEvent(
                                    state.response.data?.campaigns![index].id
                                        ?.toInt() ??
                                        0,
                                    'like'));

                                // if (state.response.data?.campaigns![index].isLike == null || state.response.data?.campaigns![index]
                                //     .isLike ==
                                //         0 ||
                                //     state.response.data?.campaigns![index].isLike == 2) {
                                //   campaignBloc.add(CampaignLikeDisLikeEvent(
                                //       state.response.data?.campaigns![index].id
                                //           ?.toInt() ??
                                //           0,
                                //       'like'));
                                //   if ((state.response.data?.campaigns![index].unlikes ?? 0) > 0) {
                                //     state.response.data?.campaigns![index]
                                //         .likes = state.response.data
                                //         ?.campaigns![index].unlikes ??
                                //         0 - 1;
                                //   }
                                //   state.response.data?.campaigns![index]
                                //       .likes ??
                                //       0 + 1;
                                // }

                              },
                              campaigns: state.response.data?.campaigns?[index],
                              buttonText: state.response.data?.campaigns?[index]
                                      .displayStatus ??
                                  '',
                              title: state
                                      .response.data?.campaigns?[index].title ??
                                  "",
                              subtitle: state.response.data?.campaigns?[index]
                                      .shortDescription ??
                                  '',
                              progress: (double.parse(state.response.data
                                          ?.campaigns?[index].percentage ??
                                      "0.0") /
                                  100),
                              color: hexToColor(
                                  state.response.data?.campaigns?[index].bg ??
                                      ''),
                            );
                          }),
                    ],
                  ),
                );
              } else if (state is CampaignFailure) {
                return Text(state.error.toString());
              }
              return Text('');
            }));
  }
}
