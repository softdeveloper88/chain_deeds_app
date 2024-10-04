import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLink {

  // Function to launch URL with confirmation dialog
  static Future<void> launchURL(BuildContext context, String urlString) async {
    Uri url = Uri.parse(urlString);

    // Show a confirmation dialog before launching the URL
    bool shouldLaunch = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open Link'),
          content: Text('Would you like to open this link? \n$urlString'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false to shouldLaunch
              },
            ),
            TextButton(
              child: const Text('Open'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Return true to shouldLaunch
              },
            ),
          ],
        );
      },
    ) ??
        false; // shouldLaunch will be false if the dialog is dismissed

    if (shouldLaunch) {

      await launchUrl(url,mode: LaunchMode.externalApplication,);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Leaving the app canceled.'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

}
