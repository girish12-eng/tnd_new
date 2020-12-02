import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaComponent extends StatefulWidget {
  String instagram, facebook, linkedIn, twitter, whatsapp;
  SocialMediaComponent(
      {this.instagram,
      this.facebook,
      this.linkedIn,
      this.twitter,
      this.whatsapp});
  @override
  _SocialMediaComponentState createState() => _SocialMediaComponentState();
}

class _SocialMediaComponentState extends State<SocialMediaComponent> {
  void launchwhatsapp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  launchSocialMediaUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                launchSocialMediaUrl(widget.instagram);
              },
              child:
                  Image.asset('assets/instagram.png', width: 30, height: 30)),
          GestureDetector(
              onTap: () {
                launchSocialMediaUrl(widget.facebook);
              },
              child: Image.asset('assets/facebook.png', width: 30, height: 30)),
          GestureDetector(
              onTap: () {
                launchSocialMediaUrl(widget.linkedIn);
              },
              child: Image.asset('assets/linkedin.png', width: 30, height: 30)),
          GestureDetector(
              onTap: () {
                launchSocialMediaUrl(widget.twitter);
              },
              child: Image.asset('assets/twitter.png', width: 30, height: 30)),
          GestureDetector(
              onTap: () {
                launchwhatsapp(phone: widget.whatsapp, message: "");
              },
              child:
                  Image.asset('assets/whatsapp2.png', width: 30, height: 30)),
        ],
      ),
    );
  }
}
