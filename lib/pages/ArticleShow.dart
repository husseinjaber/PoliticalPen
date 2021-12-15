import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:politicalpen/classes/News.dart';
import 'package:flutter/widgets.dart';
import 'package:politicalpen/widgets.dart';
//import 'package:zoomable_image/zoomable_image.dart';
//import 'package:pinch_zoom_image/pinch_zoom_image.dart';

class ArticleShow extends StatefulWidget {
  final NewsObject newsObject;
ArticleShow({this.newsObject});
  @override
  _ArticleShowState createState() => _ArticleShowState();

}

class _ArticleShowState extends State<ArticleShow> {

  @override
  Widget build(BuildContext context) {
//    String contentAr = widget.newsObject.ContentAr.replaceAll("newlinehere", "\n \n");
//    String contentEng = widget.newsObject.ContentEng.replaceAll("newlinehere", "\n \n");
    return Scaffold(
      appBar: MyAppBar(widget.newsObject.categ,true,widget.newsObject),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  SingleChildScrollView(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
//                    border: Border.all(color: Colors.black45),
//                      color: Colors.black45,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    )
                  ],
                  borderRadius: new BorderRadius.all(Radius.circular(1)),
//                    gradient: new LinearGradient(colors: Colors.black45),
                ),
                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/pics/waiting.png',
                            image:widget.newsObject.ImageUrl,
//                  height: 230,

                          ),

                      ),
                      SizedBox(height: 12,),
                      Text(

                        widget.newsObject.date,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.newsObject.title,
//              maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),


                    ],
                  )
                ),

//                SizedBox(
//                  height: 12,
//                ),
//                Text(
//                  widget.newsObject.desc,
////              maxLines: 2,
//                  style: TextStyle(color: Colors.black54, fontSize: 14),
//                ),



                 SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    widget.newsObject.ContentEng,
//              maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                    textAlign: TextAlign.justify,

                  ),
                ),
                 SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        widget.newsObject.ContentAr,
//              maxLines: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 18,),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
