import 'package:flutter/material.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final String address = '2832 Alameda St, Vernon, CA 90058, USA';
  final String phone = '+1 123-456-7890';

  Future<void> _sendEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'yasinusama414@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Contact Us',
      }),
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> _openMaps() async {
    final Uri mapsLaunchUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      query: 'q=$address',
    );

    if (await canLaunch(mapsLaunchUri.toString())) {
      await launch(mapsLaunchUri.toString());
    } else {
      throw 'Could not launch $mapsLaunchUri';
    }
  }

  Future<void> _callPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );

    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    } else {
      throw 'Could not launch phone dialer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Contact Us",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'re Here to Help!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or need assistance, please feel free to reach out to us. Our support team is available 24/7.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 32.0),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text(
                'yasinusama414@gmail.com',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Send us an email',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              onTap: () async {
                // Open email app with pre-filled recipient
                _sendEmail();
              },
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                '+1 123-456-7890',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Call us',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                // Call the phone number
                _callPhone();
              },
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                '2832 Alameda St, Vernon, CA 90058, USA',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Visit our office',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                // Open maps app with location
                _openMaps();
              },
            ),
          ],
        ),
      ),
    );
  }
}
