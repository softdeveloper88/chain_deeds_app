import 'package:chain_deeds_app/screens/campaign_screen/campaign_screen.dart';
import 'package:chain_deeds_app/screens/home_page/home_page_screen.dart';
import 'package:chain_deeds_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Members_wall_screen/members_wall_screen.dart';
import '../cod_token_screen/cod_token_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  late final List<Widget> _fragments;

  @override
  void initState() {
    // setStatusBarColor(Colors.transparent);
    _fragments = [
      HomePageScreen(),
      MembersWallScreen(),
      CampaignScreen(),
      CodTokenScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          setState(() => selectedIndex = 0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: _fragments,
        ),
        key: scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          selectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.grey,fontSize: 12),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem('ic_home', 'ic_home', 'Home'),
            _buildBottomNavigationBarItem(
                'ic_message', 'ic_message', 'Members Wall'),
            _buildBottomNavigationBarItem(
                'ic_compain', 'ic_compain', "Campaign"),
            _buildBottomNavigationBarItem(
                'ic_cod_token', 'ic_cod_token', "COD Token"),
            _buildBottomNavigationBarItem1('ic_home', 'ic_home', "Profile"),
          ],
          onTap: (val) {
            if (val == 1) {
              // _fragments[val].launch(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => _fragments[val]));
            } else {
              setState(() => selectedIndex = val);
            }
          },
          currentIndex: selectedIndex,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String icon, String activeIcon, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/vectors/$icon.svg',
          height: 24,
          width: 24,
          fit: BoxFit.cover,
        ),
        label: label,
        activeIcon: SvgPicture.asset(
          'assets/vectors/$activeIcon.svg',
          height: 26,
          width: 26,
          fit: BoxFit.cover,
        ));
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem1(
      String icon, String activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: const Icon(CupertinoIcons.person,size: 24,),
      label: label,
      activeIcon: const Icon(CupertinoIcons.person,size: 24,),
    );
  }
}
