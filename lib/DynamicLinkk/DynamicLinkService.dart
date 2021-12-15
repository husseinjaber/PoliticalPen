import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:politicalpen/DynamicLinkk/FromDynamicLink.dart';
import 'package:politicalpen/classes/News.dart';
import 'package:politicalpen/pages/ArticleShowForDynamicLink.dart';
import 'ContextForApp.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
//    final PendingDynamicLinkData data =
//    await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
//    _handleDeepLink(data,ContextForApp.MainPageKey.currentContext);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          // 3a. handle link that has been retrieved
          _handleDeepLink(dynamicLink,ContextForApp.MainPageKey.currentContext);
        }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });

      FirebaseDynamicLinks.instance.getInitialLink().then((PendingDynamicLinkData dynamicLink){
          _handleDeepLinkWhenClosed(dynamicLink,ContextForApp.MainPageKey.currentContext);

      });




  }

  void _handleDeepLink(PendingDynamicLinkData data,BuildContext context) async{
    final Uri deepLink = data?.link;
    if (deepLink != null) {

      print('_handleDeepLink | deeplink: $deepLink i am here');
      String id=deepLink.queryParameters['id'];
      String cat=deepLink.queryParameters['cat'];
      print(id+"   "+cat);
      await GoToPost(id,cat).then((NewsObject newsObject){
//          print(newsObject.title+"from DynamicLinkService ---------------------------");
        Navigator.push(ContextForApp.MainPageKey.currentContext, MaterialPageRoute(builder: (context)=>new ArticleShowForDynamicLink(newsObject: newsObject,)));
      });

    }
  }
  void _handleDeepLinkWhenClosed(PendingDynamicLinkData data,BuildContext context) async{
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      if(ContextForApp.CanFromDynamicLinkWhenAppClosed) {

      print('_handleDeepLink | deeplink: $deepLink i am here');
      String id=deepLink.queryParameters['id'];
      String cat=deepLink.queryParameters['cat'];
      print(id+"   "+cat);
      await GoToPost(id,cat).then((NewsObject newsObject){

          Navigator.push(ContextForApp.MainPageKey.currentContext,
              MaterialPageRoute(
                  builder: (context) => new ArticleShowForDynamicLink(
                    newsObject: newsObject,)));

      });
      ContextForApp.CanFromDynamicLinkWhenAppClosed=false;
      }

    }
  }


  Future<String> generateLink(String id,String categ) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://politicalpen.page.link',
      link: Uri.parse(
          'https://politicalpen.page.link/post?id=$id&cat=$categ'), // <- your paramaters
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
      androidParameters: AndroidParameters(
        packageName: 'jaber.hussein.politicalpen',
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "Political Pen News",
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
    await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    return "https://politicalpen.page.link" + shortUrl.path;
  }
}