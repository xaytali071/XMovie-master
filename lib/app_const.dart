import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_share/flutter_share.dart';

class AppConst {
   dynamicLink(
      {required String name,
      required String image,
      required String title}) async {
    const productLink = 'https://google.com';

    const dynamicLink =
        'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyAK4GFs8UTknMYOBGtS1PsN0Oz6Ex1rVPE';

    final dataShare = {
      "dynamicLinkInfo": {
        "domainUriPrefix": 'https://xmovieApp.page.link',
        "link": productLink,
        "androidInfo": {
          "androidPackageName":'com.xmovie',
        },
        "iosInfo": {
          "iosBundleId": "google.com",
        },
        "socialMetaTagInfo": {
          "socialTitle": name,
          "socialDescription": title,
          "socialImageLink": image,
        }
      }
    };

    final res =
        await http.post(Uri.parse(dynamicLink), body: jsonEncode(dataShare));

    var shareLink = jsonDecode(res.body)['shortLink'];
    await FlutterShare.share(text: name, title: title, linkUrl: shareLink);
  }

  shareApp(){
     FlutterShare.share(
         title: 'Example share',
         text: 'Example share text',
         linkUrl: 'tg://openmessage?user_id=5199957096&message_id=47501',
         chooserTitle: 'Example Chooser Title'
     );
  }
}
