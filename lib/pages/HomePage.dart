
import 'package:flutter/material.dart';
import 'package:politicalpen/DynamicLinkk/ContextForApp.dart';
import 'package:politicalpen/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:politicalpen/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politicalpen/classes/News.dart';
import 'package:politicalpen/classes/socialMedia.dart';
import 'package:politicalpen/classes/objectsForTheApp.dart';
import 'package:politicalpen/DynamicLinkk/DynamicLinkService.dart';
import '../locator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final DataBaseService dataBaseService=new DataBaseService();
  List<NewsObject> ListOfMainNews =new List<NewsObject>();
  SocialMediaAccounts socialMediaAccounts= new SocialMediaAccounts();
}

class _HomePageState extends State<HomePage> {
  String Categ;
  bool _loading;
//  var newslist;

//  List<CategorieModel> categories = List<CategorieModel>();

//  void getNews() async {
//    News news = News();
//    await news.getNews();
//    newslist = news.news;
//    setState(() {
//      _loading = false;
//    });
//  }

  getMainNews() async{
    DocumentSnapshot data0= await widget.dataBaseService.GetMainCateg();
    Categ =data0.data["CatDisplay"];
//    print("the cat is"+Categ);
    objectsForAll.AndroidLink=data0.data["AppUrl"];
//    print("current cat in home"+Categ);
    List<DocumentSnapshot> data = await widget.dataBaseService.GetNews(Categ);
    setState(() {
      int i;
        int j=data.length;
        if(j>10)
      {
        j=10;
      }
        for(i=0;i<j;i++)
        {
          NewsObject newsObject=new NewsObject();
//          print(data[i].data["isDone"].toString()+"------------------");
          if(data[i].data["isDone"].toString()=="1"){
          newsObject.title=data[i].data["title"];
          newsObject.ContentAr=data[i].data["contentAR"];
          newsObject.ContentEng=data[i].data["contentENG"];
          newsObject.desc=data[i].data["desc"];
          newsObject.id=data[i].documentID;
          newsObject.ImageUrl=data[i].data["url"];
          newsObject.date=data[i].data["date"];
          newsObject.PostLink=data[i].data["PostLink"];
          if(
          newsObject.PostLink!=null&&
          newsObject.title!=null&&
          newsObject.ContentEng!=null&&
          newsObject.ContentAr!=null&&
          newsObject.desc!=null&&
          newsObject.id!=null&&
          newsObject.date!=null&&
          newsObject.ImageUrl!=null
          ){
            print(("adding new object to home"));
            widget.ListOfMainNews.add(newsObject);
//            print(newsObject.title);

          }
          }

        }
      setState(() {
        _loading = false;
        });

    });

  }
  getSocialMediaAccounts() async{
    DocumentSnapshot data0= await widget.dataBaseService.GetsocialMedia();
    setState(() {
      widget.socialMediaAccounts.insta=data0.data["instagram"];
      widget.socialMediaAccounts.website=data0.data["website"];
      widget.socialMediaAccounts.fb=data0.data["facebook"];
      widget.socialMediaAccounts.twit=data0.data["twitter"];
    });

  }



  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getMainNews();
//    categories = getCategories();
//    getNews();
    getSocialMediaAccounts();
  }
  Future refresh()async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _loading = true;
      int j=widget.ListOfMainNews.length;
      widget.ListOfMainNews.removeRange(0, j);
    });
    getMainNews();
    getSocialMediaAccounts();
  }

  final DynamicLinkService dynamicLinkService = locator<DynamicLinkService>();
  Future handleStartUpLogic() async {
    // call handle dynamic links
    await dynamicLinkService.handleDynamicLinks();
  }

  ListView ListViewHereActivity()
  {
    Widget ListViewHere=ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
//                        print(index.toString()+"------------------------");
//                        print("checking the error of duplicating"+widget.ListOfMainNews[index].title);
//                        print(("adding new object to home builder"));
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              Container(
                width: 200,
                height: 500,
              ),
//            Center(child: Text("No Articles to show",style: TextStyle(fontSize: 20,color: Colors.black),)),
          );
        });
    if(widget.ListOfMainNews.length>0){
      ListViewHere=ListView.builder(
          itemCount: widget.ListOfMainNews.length,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
//                        print(index.toString()+"------------------------");
//                        print("checking the error of duplicating"+widget.ListOfMainNews[index].title);
//                        print(("adding new object to home builder"));
            return NewsTile(
              isFromHome: true,
              imgUrl: widget.ListOfMainNews[index].ImageUrl ?? "",
              title: widget.ListOfMainNews[index].title ?? "",
              desc: widget.ListOfMainNews[index].desc ?? "",
              contentAR: widget.ListOfMainNews[index].ContentAr ?? "",
              contentENG: widget.ListOfMainNews[index].ContentEng ?? "",
              postId: widget.ListOfMainNews[index].id ?? "",
              date: widget.ListOfMainNews[index].date ?? "",
              categ: Categ,
              PostLink:widget.ListOfMainNews[index].PostLink ?? "",
              contextHere: context,
            );
          });
    }
    return ListViewHere;
  }

  @override
  Widget build(BuildContext context) {
//    ContextForApp.MainContext=context;
    handleStartUpLogic();
    Widget ListViewHere=ListViewHereActivity();

    return Scaffold(
      key: ContextForApp.MainPageKey,
      drawer: MyAppDrawer(context,widget.socialMediaAccounts),
      appBar: MyAppBar("Political Pen",false),
      body: SafeArea(
        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Container(
                  margin: EdgeInsets.only(top: 1),
                  child: RefreshIndicator(
                    onRefresh:refresh ,
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    child: ListViewHere,
                  ),
                ),

      ),
    );
  }
}

//class CategoryCard extends StatelessWidget {
//  final String imageAssetUrl, categoryName;
//
//  CategoryCard({this.imageAssetUrl, this.categoryName});
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: (){
////        Navigator.push(context, MaterialPageRoute(
////            builder: (context) => CategoryNews(
////              newsCategory: categoryName.toLowerCase(),
////            )
////        ));
//      },
//      child: Container(
//        margin: EdgeInsets.only(right: 14),
//        child: Stack(
//          children: <Widget>[
//            ClipRRect(
//              borderRadius: BorderRadius.circular(5),
//              child: CachedNetworkImage(
//                imageUrl: imageAssetUrl,
//                height: 60,
//                width: 120,
//                fit: BoxFit.cover,
//              ),
//            ),
//            Container(
//              alignment: Alignment.center,
//              height: 60,
//              width: 120,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(5),
//                  color: Colors.black26
//              ),
//              child: Text(
//                categoryName,
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 14,
//                    fontWeight: FontWeight.w500),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}