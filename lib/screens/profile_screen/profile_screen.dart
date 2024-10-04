import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/app_sharedferences.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/common_shimmer_loading.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/repository/profile_service.dart';
import 'package:chain_deeds_app/screens/authenatication_screens/login_screen.dart';
import 'package:chain_deeds_app/screens/authenatication_screens/welcome_screen.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_bloc.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_event.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_state.dart';
import 'package:chain_deeds_app/screens/profile_screen/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/shimmer_loader/profile_screen_shimmer.dart';
import 'update_profile_password_screen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  ProfileBloc profileBloc=ProfileBloc();
 @override
  void initState() {
   profileBloc.add(ProfileDetails());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundScreenColor,
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0,
        leading: InkWell(
            onTap: (){
              NavigatorService.goBack();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),

        title: const Text('Profile',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        centerTitle: false,
      ),
      body:  BlocBuilder<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileLoading) {
              return ProfileShimmerScreen();
            } else if (state is ProfileSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Profile Section
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/profile_image.png'), // Replace with actual image asset
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            50)),
                                    child: SvgPicture.asset(
                                      'assets/vectors/ic_edit.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                             '${state.profileDetailsModel.data?.user?.firstName} ${state.profileDetailsModel.data?.user?.lastName}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'TypoGraphica',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                             Text(
                              '${state.profileDetailsModel.data?.user?.email} | ${state.profileDetailsModel.data?.user?.phone}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Profile incomplete...',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Edit Profile Section
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/vectors/ic_pencil.svg',
                                  height: 20, width: 20, color: Colors.black),
                              title: const Text('Edit profile information'),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>  EditProfileScreen(profileBloc,state.profileDetailsModel.data)));

                                // Edit profile functionality
                              },
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/vectors/ic_update_password.svg',
                                  height: 20,
                                  width: 20,
                                  color: Colors.black),
                              title: const Text('Update password'),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                         UpdateProfilePasswordScreen(profileBloc)));

                                // Update password functionality
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Additional Options Section
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                              const Icon(
                                  CupertinoIcons.person_2, color: Colors.black),
                              title: const Text('Sync Contacts'),
                              onTap: () {
                                // Sync contacts functionality
                              },
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/vectors/ic_star.svg',
                                  height: 20, width: 20, color: Colors.black),
                              title: const Text('Rate App'),
                              onTap: () {
                                // Rate app functionality
                              },
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                'assets/vectors/ic_instagram.svg',
                                color: Colors.black,
                                height: 20,
                                width: 20,
                              ),
                              title: const Text('Follow us'),
                              onTap: () {
                                // Follow us functionality
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Support Section
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/vectors/ic_message.svg',
                                  height: 20, width: 20, color: Colors.black),
                              title: const Text('Email Us'),
                              onTap: () {
                                // Email us functionality
                              },
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/vectors/ic_privacy.svg',
                                  height: 20, width: 20, color: Colors.black),
                              title: const Text('Privacy Policy'),
                              onTap: () {
                                // Privacy policy functionality
                              },
                            ),
                            ListTile(
                              leading:
                              const Icon(Icons.menu, color: Colors.black),
                              title: const Text('Terms and Conditions'),
                              onTap: () {
                                // Terms and conditions functionality
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Delete Account Button
                      MaterialButton(
                        color: AppColors.backgroundCustomLightGray,
                        onPressed: () {
                          logoutAccount(context);
                          // Delete account functionality
                        },
                        // primary: Colors.red,
                        padding:
                        const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        color: AppColors.buttonCustomRed,
                        onPressed: () {
                          deleteAccount(context);
                          // Delete account functionality
                        },
                        // primary: Colors.red,
                        padding:
                        const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/vectors/ic_cross.svg',
                              color: Colors.white,
                              height: 15,
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Delete Account',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if(state is ProfileFailure) {
              return Container();
            }
            return Container();
          })
    );
  }
  deleteAccount(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete your Account?'),
          content: const Text(
              '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.

Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
                // color: Colors.red,
              ),
              onPressed: () async {
                Map<String,dynamic> result = await ProfileService().deactivateAccount();
                if (result['status']) {
                  AppSharedPreferences().clearSharedPreferencesData(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {}

                // Call the delete account function
              },
            ),
          ],
        );
      },
    );
  }
  logoutAccount(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
              'Are you sure want to logout ?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
                // color: Colors.red,
              ),
              onPressed: () async {
                Map<String,dynamic> result = await ProfileService().logoutAccount();
                if (result['status']) {
                  AppSharedPreferences().clearSharedPreferencesData(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),(Route route)=>true
                  );
                } else {}

                // Call the delete account function
              },
            ),
          ],
        );
      },
    );
  }

}
