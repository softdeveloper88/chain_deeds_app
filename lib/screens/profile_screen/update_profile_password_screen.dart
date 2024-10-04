import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/screens/profile_screen/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text_field_widget.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_state.dart';

class UpdateProfilePasswordScreen extends StatefulWidget {
   UpdateProfilePasswordScreen( this.profileBloc,{super.key});
  ProfileBloc profileBloc;
  @override
  State<UpdateProfilePasswordScreen> createState() =>
      _UpdateProfilePasswordScreenState();
}

class _UpdateProfilePasswordScreenState extends State<UpdateProfilePasswordScreen> {

  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
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
                print('errors');

                if (state.response['status']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Update password successful!')),
                  );
                  Navigator.pop(context);
                } else {
                  if(state.response.containsKey('errors')) {
                    showErrorDialog(state.response['errors'], context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.response['message'])),
                    );
                  }else{

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.response['message'])),
                    );
                  }

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
                      controller: oldPasswordController,
                      labelText: 'Old password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     CustomTextFieldWidget(
                       controller: newPasswordController,
                      labelText: 'New password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     CustomTextFieldWidget(
                       controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: MaterialButton(
                        elevation: 0,
                        minWidth: 90.w,
                        onPressed: () {
                          if(oldPasswordController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Required Old Password')),
                            );
                            return;
                          }
                          if(newPasswordController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Required new Password!')),
                            );
                            return;
                          }
                          if(confirmPasswordController.text.isEmpty || newPasswordController.text !=confirmPasswordController.text){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password not match')),
                            );
                            return;
                          }
                          widget.profileBloc.add(PasswordUpdateEvent(
                           oldPasswordController.text,newPasswordController.text,confirmPasswordController.text
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
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'BG Flame Bold'),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )));
  }
}
