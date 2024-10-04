import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../blog_screen/add_blog_post_screen.dart';

class SuccessThankYouScreen extends StatefulWidget {
  @override
  _SuccessThankYouScreenState createState() => _SuccessThankYouScreenState();
}

class _SuccessThankYouScreenState extends State<SuccessThankYouScreen> {
  String _selectedCountry = 'Palestine'; // Initial value for the dropdown

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.backgroundScreenColor,
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
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/vectors/bg_image.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child:const ListTile(title: Text("Thank you",),subtitle: Text("For contributing one the member’s wall.To avoid spam admin will have to approve "),
            )),
          ),
        ],
      ),
    );
  }

}