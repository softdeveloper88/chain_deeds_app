import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'send_email_confirmation_dialog.dart';

class ForgotPasswordDialog {
  TextEditingController _emailControllerText=TextEditingController();
 AuthBloc authBloc;
  ForgotPasswordDialog(this.authBloc);
  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .4,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 24, left: 24),
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'TypoGraphica',
                              fontSize: 16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 24),
                        child: Text(
                          "We will send instructions to change your\npassword on the following email:",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'BG Flame Light',
                              fontSize: 12),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 24),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: -.1,
                              color: Colors.black,
                              fontFamily: 'TypoGraphica'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              color: const Color(0xfff5F9FC),
                              borderRadius: BorderRadius.circular(10)),
                          child:  TextField(
                            controller: _emailControllerText,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Type your email',
                              hintStyle: TextStyle(
                                  fontFamily: 'BG Flame Light',
                                  fontSize: 14,
                                  color: Color(0xfffa8a8a8),
                                  fontWeight: FontWeight.normal),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              // Adjust text padding
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 10),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: "BG Flame",
                                    ),
                                  )),
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                              if (state is AuthLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 10),
                                child: TextButton(
                                    onPressed: () {
                                      if(_emailControllerText.text.isEmpty){
                                        return;
                                      }
                                      authBloc.add(ForgotSubmitted(_emailControllerText.text));
                                      Navigator.of(context).pop();
                                      SendEmailConfirmationDialog(authBloc,_emailControllerText.text)
                                          .show(context);
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: "BG Flame Bold",
                                      ),
                                    )),
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
