
import 'package:flutter/material.dart';
import 'package:politicalpen/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:politicalpen/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politicalpen/classes/News.dart';

class ArticleOfCat extends StatefulWidget {
  final String categ;
  ArticleOfCat({this.categ});
  @override
  _ArticleOfCatState createState() => _ArticleOfCatState();
  final DataBaseService dataBaseService=new DataBaseService();
  List<NewsObject> ListOfNews =new List<NewsObject>();

}

class _ArticleOfCatState extends State<ArticleOfCat> {

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
  List<DocumentSnapshot> data;
  ScrollController _scrollControllerr;
//  int _currentMax = 10;
  int Loaded=0;
  bool isAllLoaded=false;
  getMainNews() async{
    data = await widget.dataBaseService.GetNews(widget.categ);
    setState(() {
      int i;
      int j=10;
      if(data.length<=10){j=data.length;isAllLoaded=true;}
      for(i=0;i<j;i++)
      {
        if(data[i].data["isDone"].toString()=="1"&&data[i]!=null)
        {
        NewsObject newsObject=new NewsObject();
        newsObject.title=data[i].data["title"];
        newsObject.ContentAr=data[i].data["contentAR"];
        newsObject.ContentEng=data[i].data["contentENG"];
        newsObject.desc=data[i].data["desc"];
        newsObject.id=data[i].documentID;
        newsObject.ImageUrl=data[i].data["url"];
        newsObject.date=data[i].data["date"];
        newsObject.PostLink=data[i].data["PostLink"];
//        newsObject.categ=widget.categ;
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
          widget.ListOfNews.add(newsObject);
//          print(newsObject.title);
            Loaded=i+1;
        }
      }}
      setState(() {
        _loading = false;
      });


    });

  }
  _getMoreData() {
    print("get more data");
    int j=Loaded+10;
    if(j>=data.length){
      j=data.length;
      isAllLoaded=true;
    }
    for(int i=Loaded;i<j;i++)
    {
      if(data[i].data["isDone"].toString()=="1"&&data[i]!=null)
      {
        NewsObject newsObject=new NewsObject();
        newsObject.title=data[i].data["title"];
        newsObject.ContentAr=data[i].data["contentAR"];
        newsObject.ContentEng=data[i].data["contentENG"];
        newsObject.desc=data[i].data["desc"];
        newsObject.id=data[i].documentID;
        newsObject.ImageUrl=data[i].data["url"];
        newsObject.date=data[i].data["date"];
        newsObject.PostLink=data[i].data["PostLink"];
//        newsObject.categ=widget.categ;
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
          widget.ListOfNews.add(newsObject);
//          print(newsObject.title);
          Loaded=i+1;
        }
      }}
    setState(() {});
  }
  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    _scrollControllerr = ScrollController();
    _scrollControllerr.addListener(_scrollListener);
    getMainNews();
//    categories = getCategories();
//    getNews();
    print("adding listner");

  }
  _scrollListener() {
    if (_scrollControllerr.offset >= _scrollControllerr.position.maxScrollExtent &&
        !_scrollControllerr.position.outOfRange) {
      setState(() {
        print("reach the bottom");
        if(!isAllLoaded){
          _getMoreData();
        }
      });
    }
    if (_scrollControllerr.offset <= _scrollControllerr.position.minScrollExtent &&
        !_scrollControllerr.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      drawer: MyAppDrawer(context),
      appBar: MyAppBar(widget.categ,false),
      body: SafeArea(
        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Container(
                  margin: EdgeInsets.only(top: 1),
                  child: ListView.builder(
                      controller:_scrollControllerr ,
                      itemCount: widget.ListOfNews.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                            isFromHome: false,
                            imgUrl: widget.ListOfNews[index].ImageUrl ?? "",
                            title: widget.ListOfNews[index].title ?? "",
                            desc: widget.ListOfNews[index].desc ?? "",
                            contentAR: widget.ListOfNews[index].ContentAr ?? "",
                            contentENG: widget.ListOfNews[index].ContentEng ?? "",
                            postId: widget.ListOfNews[index].id ?? "",
                            date: widget.ListOfNews[index].date ?? "",
                            categ:widget.categ,
                            PostLink:widget.ListOfNews[index].PostLink ?? "",
                            contextHere: context,

                        );
                      }),
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