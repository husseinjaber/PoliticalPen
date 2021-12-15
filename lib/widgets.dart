
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:politicalpen/classes/News.dart';
import 'pages/ArticleShow.dart';
import 'pages/AreiclesOfSpecificCat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'classes/socialMedia.dart';
import 'package:share/share.dart';
import 'package:politicalpen/pages/AdminMainPage.dart';
import 'db.dart';

Widget MyAppBar(String title,bool isArticleShow,[NewsObject newsObject]){
//  print(title+"=============");
  if(title=="local")
    {
      title="National News";
    }
  if(title=="regional")
  {
    title="Regional News";
  }
  if(title=="international")
  {
    title="International News";
  }
  if(title=="personal")
  {
    title="Personal Articles";
  }
  Widget NewWidget=Container();

  if(isArticleShow)
    {
      String whatsappMessage;
      whatsappMessage=newsObject.PostLink+"\n"+newsObject.title;
      NewWidget=Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () {
              Share.share(whatsappMessage);
            },
            child: Container(
              width: 60,
              child: Icon(
                Icons.share,
                size: 26.0,
              ),
            ),
          )
      );
    }
  return AppBar(
    centerTitle: true,
    title:Text(
      title,
      style:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20,
          fontStyle: FontStyle.italic,
      ),
    ),
      actions: <Widget>[
        NewWidget,
      ],

    backgroundColor: Colors.black,
    elevation: 0.0,
  );
}


Widget MyAppBarForDynamicLinks(String title,[NewsObject newsObject,BuildContext context]){
  if(title=="local")
  {
    title="National News";
  }
  if(title=="regional")
  {
    title="National News";
  }
  if(title=="international")
  {
    title="International News";
  }
  if(title=="personal")
  {
    title="Personal Articles";
  }
  Widget NewWidget=Container();
  Widget CloseWidget=Container();

    CloseWidget=Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          },
        child: Container(
          width: 25,
          child: Icon(
            Icons.close,
            size: 26.0,
          ),
        ),
      ),
    );

    String whatsappMessage;
    whatsappMessage=newsObject.PostLink+"\n"+newsObject.title;
    NewWidget=Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: InkWell(
          onTap: () {
            Share.share(whatsappMessage);
          },
          child: Container(
            width: 20,
            child: Icon(
              Icons.share,
              size: 26.0,
            ),
          ),
        )
    );

  return AppBar(
    centerTitle: true,
    leading: new Container(),
    title:Text(
      title,
      style:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20,
          fontStyle: FontStyle.italic,
      ),    ),
    actions: <Widget>[
      NewWidget,
      CloseWidget,
    ],

    backgroundColor: Colors.black,
    elevation: 0.0,
  );
}





Widget MyAppDrawer(BuildContext context,SocialMediaAccounts socialMediaAccounts){
  return Drawer(
    child: ListView(
      children: <Widget>[

        SizedBox(height: 5,),
        InkWell(
          onTap: (

              ){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new ArticleOfCat(categ: "local",)));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading:Icon(Icons.home,color: Colors.black,size: 22,),
              title: Text("National News",style: TextStyle(color:Colors.black,fontSize: 18 ),),
            ),
          ),
        ),
//        SizedBox(height: 1,),
        InkWell(
          onTap: (

              ){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new ArticleOfCat(categ: "regional",)));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading:Icon(Icons.device_hub,color: Colors.black,size: 22,),
              title: Text("Regional News",style: TextStyle(color:Colors.black,fontSize: 18 ),),
            ),
          ),
        ),
        InkWell(
          onTap: (

              ){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new ArticleOfCat(categ: "international",)));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading:Icon(Icons.language,color: Colors.black,size: 22,),
              title: Text("International News",style: TextStyle(color:Colors.black,fontSize: 18 ),),
            ),
          ),
        ),
        InkWell(
          onTap: (

              ){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new ArticleOfCat(categ: "personal",)));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              leading:Icon(Icons.person,color: Colors.black,size: 22,),
              title: Text("Personal Articles",style: TextStyle(color:Colors.black,fontSize: 18 ),),
            ),
          ),
        ),
        Divider(),



        //   FOR ADMIN ONLYY
//        InkWell(
//          onTap: (
//
//              ){
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>
//            new AdminMainPage(),
//            ));
//          },
//          child: Padding(
//            padding: const EdgeInsets.all(2.0),
//            child: ListTile(
//              leading:Icon(Icons.person,color: Colors.black,size: 22,),
//              title: Text("For Admin Only",style: TextStyle(color:Colors.black,fontSize: 18 ),),
//            ),
//          ),
//        ),
//        Divider(),




        SizedBox(width:10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            InkWell(
              onTap: (){
                if(socialMediaAccounts.insta!="a"){
                  _launchURL(socialMediaAccounts.insta);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/pics/in.png'),),
              ),
            ),
            SizedBox(width: 25,),
            InkWell(
              onTap: (){
                if(socialMediaAccounts.insta!="a"){
                  _launchURL(socialMediaAccounts.fb);
                }

              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/pics/fb.png'),),
              ),
            ),
            SizedBox(width: 25,),
            InkWell(
              onTap: (){
                if(socialMediaAccounts.insta!="a"){
                  _launchURL(socialMediaAccounts.twit);
                }

              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/pics/twitter.png'),),
              ),
            ),
            SizedBox(width: 25,),
            InkWell(
              onTap: (){
                if(socialMediaAccounts.insta!="a"){
                  _launchURL(socialMediaAccounts.website);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/pics/website.png'),),
              ),
            ),
            SizedBox(width: 25,),

          ],
        ),
        SizedBox(height: 350,),
        Center(
          child: Text("@HusseinJaber",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 4,fontStyle: FontStyle.italic),),
        ),
        InkWell(
          onTap: (){
              _launchURL("https://www.instagram.com/7senj/");
          },
          child: Container(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Image(
                width: 1,
                height: 15,
                image: AssetImage('assets/pics/in.png'),),
            ),
          ),
        ),

      ],
    ),
  );


}
_launchURL(String fbORinsta) async {
  String url = fbORinsta;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, contentAR,contentENG, postId,date,categ,PostLink;
  final bool isFromHome;
  final BuildContext contextHere;
  NewsTile({this.imgUrl,this.contextHere,this.isFromHome, this.PostLink,this.desc, this.title, this.categ,this.contentAR,this.contentENG,this.date, @required this.postId});
  bool isDeleted=false;
  DataBaseService dataBaseService = new DataBaseService();

  void DeleteProduct() {
    if(!isDeleted){
//      ProductService prod= new ProductService();
      // flutter defined function
      showDialog(
        context: contextHere,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(""),
            content: new Text("Are you sure you want to delete this article ?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("yes"),
                onPressed: () {
                  isDeleted=true;
                  dataBaseService.deleteProduct(
                    pic:imgUrl ,
                    Id: postId,
                    Cat: categ
                  );

                  Navigator.of(context).pop();
                },
              ), new FlatButton(
                child: new Text("no"),
                onPressed: () {
//                  print("nooo");
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        },
      );
    }}

  @override
  Widget build(BuildContext context) {
    Widget Delete=new Container();
    String DateHere = date.split(" ")[1]+" "+date.split(" ")[2];



//   FOR ADMIN ONLYY
//
//    if(!isFromHome){
//     Delete=Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: () {
//           DeleteProduct();
//         },
//         child: Container(
//           width: 50,
//           height: 50,
//           child: Icon(
//             Icons.delete_forever,
//             color: Colors.red,
//             size: 50.0,
//           ),
//         ),
//       ),
//     );
//    }


    NewsObject newsObjectToSendToShow=new NewsObject(
        PostLink: PostLink,
        ImageUrl:imgUrl,
        id: postId,
        categ: categ,
        date: DateHere,
        desc: desc,
        title: title,
        ContentAr: contentAR,
        ContentEng: contentENG);
//    print(newsObjectToSendToShow.title+newsObjectToSendToShow.PostLink+"-----------------");
    return GestureDetector(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ArticleShow(
                newsObject:newsObjectToSendToShow ,
              )
          ));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 24),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
//                    border: Border.all(color: Colors.black45),
//                      color: Colors.black45,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0, // has the effect of softening the shadow
                          spreadRadius: 1.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                    borderRadius: new BorderRadius.all(Radius.circular(1)),
//                    gradient: new LinearGradient(colors: Colors.black45),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            imgUrl,
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: 12,),
                         Center(
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               Text(

                                 DateHere,
                                 maxLines: 1,
                                 style: TextStyle(
                                     color: Colors.black87,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w500),
                               ),
                               SizedBox(width: 60,),
                               Delete,
                             ],
                           ),
                         ),
                             Text(
                              title,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),


                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        desc,
                        maxLines: 3,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}