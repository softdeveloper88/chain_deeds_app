import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/bloc/member_bloc.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/bloc/member_event.dart';
import 'package:chain_deeds_app/screens/Members_wall_screen/success_thank_you_screen.dart';
import 'package:chain_deeds_app/screens/blog_screen/add_blog_post_screen.dart';
import 'package:chain_deeds_app/widgets/profile_dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/app_colors.dart';
import 'bloc/member_state.dart';

class AddCampaignIdeaScreen extends StatefulWidget {
  @override
  _AddCampaignIdeaScreenState createState() => _AddCampaignIdeaScreenState();
}

class _AddCampaignIdeaScreenState extends State<AddCampaignIdeaScreen> {
  String _selectedCountry = 'Palestine'; // Initial value for the dropdown
  MemberBloc memberBloc = MemberBloc();
  Countries? countries;
  List<Countries>? countryList;
  TextEditingController tileEditingController=TextEditingController();
  TextEditingController descriptionEditingController=TextEditingController();

  @override
  void initState() {
    memberBloc.add(GetCountryEvent());

    super.initState();
  }

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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBlogPostScreen()));
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
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Campaign idea's",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocListener<MemberBloc, MemberState>(
          bloc: memberBloc,
          listener: (context, state) {
            if (state is MemberFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is MemberSuccess) {
              countryList = memberBloc.countryModel?.data?.countries ?? [];
              if (state.response.isNotEmpty) {
                if (state.response['status']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.response['message'] ?? '')),
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuccessThankYouScreen()));
                } else {
                  if (state.response.containsKey('errors')) {
                    showErrorDialog(state.response['errors'], context);
                  } else if (state.response.containsKey('message')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Member add  failed!${state.response['message']}')),
                    );
                  }
                }
              }
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/vectors/bg_image.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Campaign Idea's",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Where will the funds go?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose the location where you plan to donate to:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<MemberBloc, MemberState>(
                          bloc: memberBloc,
                          builder: (BuildContext context, MemberState state) {
                            if (state is MemberLoading) {
                              return Container(

                                color: Colors.white,
                                child: const Text('Country Loading...'),);
                            }
                            return ProfileDropdownField(
                              color: Colors.white,
                              getItemLabel: (item) => item!.name!,
                              onChanged: (country) {
                                countries = country;
                              },
                              label: 'Country',
                              items: countryList ?? [],
                              selectedItem: countries,
                            );
                          }),
                      const SizedBox(height: 16),
                      const Text(
                        'What best describes the campaign?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildTextField('Campaign',tileEditingController),
                      const SizedBox(height: 16),
                      const Text(
                        'Who is the campaign for?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildTextField('Who is the campaign for?',descriptionEditingController),
                      const SizedBox(height: 32),
                      buildPostButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCountry = newValue!;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: <String>['Palestine', 'Syria', 'Yemen', 'Somalia']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildTextField(String hintText,controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  Widget buildPostButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          memberBloc.add(AddCampaignIdea(countries!.id.toString(), tileEditingController.text, descriptionEditingController.text));
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => SuccessThankYouScreen()));
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
