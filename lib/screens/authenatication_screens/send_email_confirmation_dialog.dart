import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_event.dart';
import 'package:flutter/material.dart';

import 'bloc/auth_bloc.dart';

class SendEmailConfirmationDialog {
  SendEmailConfirmationDialog(this.authBloc,this.email);
String email;
  AuthBloc authBloc;

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    const Text("Please check your e-mail for the Password link we sent you.",
                      style: TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Didn’t receive an email?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),GestureDetector(
                      onTap: () {
                        authBloc.add(ForgotSubmitted(email));
                        Navigator.of(context).pop();
                        // Handle resend link click
                      },
                      child: const Text(
                        "Click here to resend the link",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
