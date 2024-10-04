import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/model/country_model/country_model.dart';
import 'package:chain_deeds_app/model/profile_model/profile_details_model.dart';
import 'package:chain_deeds_app/repository/profile_service.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_bloc.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_event.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_state.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_state.dart';
import 'package:chain_deeds_app/screens/phone_screen/verification_code_screen.dart';
import 'package:chain_deeds_app/widgets/custom_phone_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../main_screen/main_screen.dart';



class PhoneScreen extends StatefulWidget {

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController? phoneNameController;
  String countryCode = 'US';
  String dialCode = '+1';
  PhoneBloc phoneBloc =PhoneBloc();
  @override
  void initState() {
    phoneNameController = TextEditingController();
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
          title: const Text('Add Phone',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocListener(
            bloc: phoneBloc,
            listener: (context, state) {
              if (state is PhoneFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is PhoneSuccess) {
                print('errors');

                if (state.response['status']) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>
                          VerificationCodeScreen(
                              isFrom: 'login',
                              onSubmit: (verified) {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                    builder: (context) => const MainScreen()));
                              })));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Phone verified successful!')),
                  );
                } else {

                  showErrorDialog(state.response['errors'], context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Phone verified failed!')),
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
                      height: 60,
                    ),
                    BlocBuilder<PhoneBloc, PhoneState>(
                        builder: (context, state) {
                          if (state is PhoneLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return Center(
                            child: MaterialButton(
                              elevation: 0,
                              minWidth: 90.w,
                              onPressed: () {
                                phoneBloc.add(AddPhoneVerifiedEvent(
                                  phoneNameController?.text ?? '',
                                  countryCode,
                                  dialCode,
                                ));
                              },
                              color: const Color(0xFFFFD319),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: MediaQuery.of(context).size.height * 0.06,
                                child: const Center(
                                    child: Text(
                                      "Verified",
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
            )

            ));
  }
}
