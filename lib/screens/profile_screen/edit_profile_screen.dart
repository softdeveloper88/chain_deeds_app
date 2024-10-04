import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:chain_deeds_app/repository/profile_service.dart';
import 'package:chain_deeds_app/screens/authenatication_screens/login_screen.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_bloc.dart';
import 'package:chain_deeds_app/screens/phone_screen/verification_code_screen.dart';
import 'package:chain_deeds_app/widgets/custom_phone_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/constants.dart';
import '../../widgets/custom_text_field_widget.dart';
import '../../widgets/profile_dropdown_field_widget.dart';
import '../phone_screen/bloc/phone_event.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen(this.profileBloc, this.data, {super.key});

  Data? data;
  ProfileBloc profileBloc;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController? fullNameController;
  TextEditingController? nickNameController;
  TextEditingController? emailController;
  TextEditingController? dateNameController;
  TextEditingController? phoneNameController;
  TextEditingController? professionalController;
  TextEditingController? placeWorshipController;
  String countryCode = 'US';

  String dialCode = '+1';
  String selectedGender = 'Male';
  String selectedCountry = 'United Kingdom';
  Countries? countries;

  @override
  void initState() {
   countryList= widget.profileBloc.countryModel?.data?.countries??[];

   if(widget.data?.user?.country!=null){
     int id=widget.data?.user?.country;
     for (var item in countryList) {
       if(item.id==id) {
         countries = item;
             // Countries(id: widget.data?.user?.country,name: item.name);
        break;
       }
     }

   }else{
     countries=widget.profileBloc.countryModel?.data?.countries![0];
   }
   selectedGender= widget.data?.user?.gender ?? 'Male';
   countryCode= widget.data?.user?.countryCode ?? 'US';
   dialCode= widget.data?.user?.dialCode ?? '+1';
    fullNameController = TextEditingController(text: widget.data?.user?.firstName ?? '');
    nickNameController = TextEditingController(text: widget.data?.user?.lastName ?? '');
    emailController = TextEditingController(text: widget.data?.user?.email ?? '');
    dateNameController = TextEditingController(text: widget.data?.user?.dob ?? '');
    phoneNameController = TextEditingController(text: widget.data?.user?.phone ?? '');
    professionalController =
        TextEditingController(text: widget.data?.user?.profession ?? '');
    placeWorshipController =
        TextEditingController(text: widget.data?.user?.placeOfWorship ?? '');

    super.initState();
  }
  List<Countries> countryList=[];
  List<String> countryStringList=[];
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
          title: const Text('Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          bloc: widget.profileBloc,
            listener: (context, state) {
              if (state is ProfileFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is ProfileSuccess) {

                if (state.response['status']) {
                  // Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Update profile successful!')),
                  );
                } else {

                  showErrorDialog(state.response['errors'], context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile update failed!')),
                  );
                }
              }
            },
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Full Name',
                      controller: fullNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Last Name',
                      controller: nickNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          print(pickedDate);
                          DateTime dateTime =
                          DateTime.parse(pickedDate.toIso8601String());

                          // Format the DateTime object to display only the date portion
                          String formattedDate =
                              "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

                          // Update the text field value when a date is selected
                          dateNameController?.text = formattedDate;

                          // Call onSave if provided

                        }
                      },
                      labelText: 'Date of birth',
                      controller: dateNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomPhoneTextFieldWidget(
                      initialCountryCode:countryCode,
                      favoriteCountries:[dialCode,countryCode],
                      controller: phoneNameController,
                      onChange: (code) {
                        dialCode = code.dialCode ?? "+1";
                        countryCode = code.code ?? "US";

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Expanded(
                          child: ProfileDropdownField(
                            getItemLabel: (item) => item!.name!,
                            onChanged: (country){
                              countries=country;

                            },
                        label: 'Country',
                        items: countryList,
                        selectedItem: countries,
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ProfileDropdownField(
                            getItemLabel: (item) => item,
                            onChanged: (value){
                              selectedGender=value??'Male';
                            },
                        label: 'Gender',
                        items: const ['Male', 'Female'],
                        selectedItem: selectedGender,
                      )),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Professional',
                      controller: professionalController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Place Worship',
                      controller: placeWorshipController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Center(
                        child: MaterialButton(
                          elevation: 0,
                          minWidth: 90.w,
                          onPressed: () {
                            if(phoneNameController?.text != widget.data?.user?.phone) {

                              // PhoneBloc().add(ChangePhoneVerifiedEvent(widget.data?.user?.phone??"",widget.data?.user?.countryCode??"",widget.data?.user?.dialCode??"",  phoneNameController?.text ??"", countryCode??'', dialCode??''));
                              widget.profileBloc.add(
                                  ProfileUpdateEvent(
                                    Constants.logInUserId,
                                    fullNameController?.text ?? '',
                                    nickNameController?.text ?? '',
                                    emailController?.text ?? '',
                                    phoneNameController?.text ?? '',
                                    dialCode,
                                    countryCode,
                                    dateNameController?.text ?? '',
                                    selectedGender,
                                    countries!.id.toString(),
                                    widget.data?.user?.address ?? '',
                                    professionalController?.text ?? '',
                                    placeWorshipController?.text ?? '',
                                  ));
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      VerificationCodeScreen(
                                         isFrom: 'profile_edit',
                                          oldPhone:widget.data?.user?.phone??'',
                                          oldCountryCode:widget.data?.user?.countryCode??'',
                                          oldDialCode:widget.data?.user?.dialCode??'',
                                        phone:   phoneNameController?.text ?? '',
                                         dialCode:  dialCode,
                                          countryCode: countryCode,onSubmit: (verified) {
                                        if (verified) {
                                          Navigator.pop(context);
                                        }
                                      })));
                            }else{
                              widget.profileBloc.add(
                                  ProfileUpdateEvent(
                                    Constants.logInUserId,
                                    fullNameController?.text ?? '',
                                    nickNameController?.text ?? '',
                                    emailController?.text ?? '',
                                    phoneNameController?.text ?? '',
                                    dialCode,
                                    countryCode,
                                    dateNameController?.text ?? '',
                                    selectedGender,
                                    countries!.id.toString(),
                                    widget.data?.user?.address ??
                                        '',
                                    professionalController?.text ??
                                        '',
                                    placeWorshipController?.text ??
                                        '',
                                  ));
                            }


                          },
                          color: const Color(0xFFFFD319),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: const Center(
                                child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: 'BG Flame Bold'),
                            )),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )));
  }
}
