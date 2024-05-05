import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xmovie/view/components/style.dart';

import '../button/custom_social_button.dart';

class CustomSocialMedia extends StatelessWidget {
  const CustomSocialMedia({super.key});
  launchPinterest() async {
    var webUrl = "https://pl.pinterest.com/SilkRouteGlobalUK/";
    try {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  launchTelegram() async {
    var nativeUrl = "t.me/+lL3w8LjOHrc5NTli";
    var webUrl = "https://t.me/+lL3w8LjOHrc5NTli";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  launchFaceBook() async {
    var nativeUrl = "facebook.com/SilkRouteGlobalUK?mibextid=ZbWKwL";
    var webUrl = "https://www.facebook.com/SilkRouteGlobalUK?mibextid=ZbWKwL";
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    final Uri url = Uri.parse('https://silkrouteglobal.co.uk/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  launchInstagram() async {
    var nativeUrl = "instagram.com/silkrouteglobaluk/?hl=ru";
    var webUrl = "https://www.instagram.com/silkrouteglobaluk/?hl=ru";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSocialButton(
          onTap: () {},
          height: 35,
          width: 70,
          child: SvgPicture.asset(
            "assets/you_tube.svg",
            color: Style.greyColor,
            height: 20.r,
          ),
        ),
        CustomSocialButton(
          onTap: () {
            launchTelegram();
          },
          width: 70,
          height: 35,
          child: Icon(
            Icons.telegram,
            size: 30.r,
            color: Style.greyColor,
          ),
        ),
        CustomSocialButton(
          onTap: () {
            launchFaceBook();
          },
          width: 70,
          height: 35,
          child: Icon(
            Icons.facebook,
            size: 30.r,
            color: Style.greyColor,
          ),
        ),
        CustomSocialButton(
          onTap: () {
            launchInstagram();
          },
          height: 35,
          width: 70,
          child: SvgPicture.asset(
            "assets/instagram.svg",
            color: Style.greyColor,
            height: 20.r,
          ),
        ),
      ],
    );
  }
}
