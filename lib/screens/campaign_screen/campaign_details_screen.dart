import 'package:chain_deeds_app/core/convert_hex_color.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/widgets/mile_stone_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/app_colors.dart';

class CampaignDetailsScreen extends StatelessWidget {
  CampaignDetailsScreen(this.campaign, {super.key});
  Campaigns? campaign;
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

        title: const Text('Campaign',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MilestoneCard(
                campaigns: campaign,
                buttonText: campaign?.displayStatus ??
                    '',
                title: campaign?.title??"",
                subtitle: campaign?.shortDescription??'',
                progress: 0.62,
                color: hexToColor(campaign?.bg ?? ''),
              ),
              // Campaign Milestone Card
              // Card(
              //   color: Color(0xFFFFD700),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           '10K ACRE    100K MEMBERS\nMILESTONE',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 24,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Text(
              //           '100K MEMBER TARGET',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //           ),
              //         ),
              //         SizedBox(height: 16),
              //         // Progress Bar
              //         Stack(
              //           children: [
              //             Container(
              //               height: 20,
              //               decoration: BoxDecoration(
              //                 color: Colors.grey.shade300,
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //             ),
              //             FractionallySizedBox(
              //               widthFactor: 0.61, // Adjust based on percentage
              //               child: Container(
              //                 height: 20,
              //                 decoration: BoxDecoration(
              //                   color: Colors.teal,
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 8),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '62%',
              //               style: TextStyle(fontSize: 16),
              //             ),
              //             Text(
              //               '61,000 members',
              //               style: TextStyle(fontSize: 16),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Center(
              //           child: ElevatedButton(
              //             onPressed: () {
              //               // Implement support button functionality
              //             },
              //             style: ElevatedButton.styleFrom(
              //               // primary: Colors.black,
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 60, vertical: 12),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(24.0),
              //               ),
              //             ),
              //             child: Text(
              //               'Support',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 18,
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               children: [
              //                 Icon(Icons.favorite, color: Colors.red),
              //                 SizedBox(width: 4),
              //                 Text('861'),
              //                 SizedBox(width: 16),
              //                 Icon(Icons.thumb_down, color: Colors.grey),
              //                 SizedBox(width: 4),
              //                 Text('5'),
              //               ],
              //             ),
              //             ElevatedButton.icon(
              //               onPressed: () {
              //                 // Implement share button functionality
              //               },
              //               icon: Icon(Icons.share, color: Colors.black),
              //               label: Text(
              //                 'Share',
              //                 style: TextStyle(color: Colors.black),
              //               ),
              //               style: ElevatedButton.styleFrom(
              //                 // primary: Colors.yellow.shade700,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(24.0),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16),
              // Text content
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. '
                      'It has roots in a piece of classical Latin literature from 45 BC, '
                      'making it over 2000 years old. Richard McClintock, a Latin professor '
                      'at Hampden-Sydney College in Virginia, looked up one of the more obscure '
                      'Latin words, consectetur, from a Lorem Ipsum passage, and going through the '
                      'cites of the word in classical literature, discovered the undoubtable source. '
                      'Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et '
                      'Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book '
                      'is a treatise on the theory of ethics, very popular during the Renaissance. The '
                      'first line of Lorem Ipsum.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              // New Subscribers List
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New Subscribers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [

                        SubscriberTile(name: 'Khaled', memberNumber: 59995),
                        SubscriberTile(name: 'Mostafa', memberNumber: 59996),
                        SubscriberTile(name: 'Mohammad', memberNumber: 59997),
                        SubscriberTile(name: 'Ali', memberNumber: 59998),
                        SubscriberTile(name: 'Harun', memberNumber: 59999),
                      ],
                    ),
                    Center(
                      child: MaterialButton(
                        minWidth: 50.w,
                        height: 40,
                        color: Colors.black,
                        onPressed: () {
                          // Implement load more functionality
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: const Text(
                          'Load More',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: MaterialButton(
                  minWidth: 90.w,
                  height: 50,
                  color: Colors.black,
                  onPressed: () {
                    // Implement load more functionality
                  },
                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  child: const Text(
                    'Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriberTile extends StatelessWidget {
  final String name;
  final int memberNumber;

  SubscriberTile({super.key, required this.name, required this.memberNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundColor: Colors.yellow.shade700,
        child:  SvgPicture.asset('assets/vectors/ic_money_man.svg', color: Colors.black),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('member $memberNumber'),
    );
  }
}