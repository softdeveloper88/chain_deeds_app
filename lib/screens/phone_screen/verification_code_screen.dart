import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_bloc.dart';
import 'package:chain_deeds_app/screens/phone_screen/bloc/phone_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/show_error_dialog.dart';
import 'bloc/phone_event.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({required this.isFrom,this.oldPhone,this.oldCountryCode,this.oldDialCode,this.phone,this.countryCode,this.dialCode,required this.onSubmit});
  Function( bool verified) onSubmit;
  String? oldPhone;
  String? oldCountryCode;
  String? oldDialCode;
  String? phone;
  String? countryCode;
  String? dialCode;
  String isFrom;
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _codeController = List<TextEditingController>.generate(6, (index) => TextEditingController());

  // To control focus shifting between text fields
  final _focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
  PhoneBloc phoneBloc=PhoneBloc();
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<PhoneBloc, PhoneState>(
          bloc: phoneBloc,
          listener: (context, state) {
            if (state is PhoneFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }else if (state is PhoneSuccess) {
              if (state.response['status']) {
                 widget.onSubmit(true);
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(widget.isFrom =='signup'? 'Sign up successful!':'Login successful!')),
                );
              } else {
                if(state.response.containsKey('errors')) {
                  showErrorDialog(state.response['errors'], context);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(widget.isFrom =='signup'? 'Sign up Failed!':'Login Failed!')),

                );
              }
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Please enter the 6-digit code sent to your phone",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(6, (index) {
                      // return Container();
                      print(index);
                      return _buildCodeBox(index);
                    }),
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    minWidth: 80.w,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: _verifyCode,
                    color: AppColors.customYellow,
                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _codeController[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus(); // Move to the next box
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus(); // Move to the previous box
          }
        },
      ),
    );
  }

  void _verifyCode() {
    String verificationCode = _codeController.map((controller) => controller.text).join();
    if (verificationCode.length == 6) {
      // TODO: Handle verification code logic
      phoneBloc.add(CodeVerificationEvent(verificationCode));

    } else {
      // Show error if code is not complete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete 6-digit code")),
      );
    }
  }
}