import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';
import 'AddArticle.dart';
import 'EditMainNews.dart';
class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Admin Only",false),
      body:Padding(
        padding: EdgeInsets.all(2),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                    new EditMainNews(),
                    ));

              }
              ,child: Center(
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.black,
                    borderRadius: new BorderRadius.all(Radius.circular(55))
                  ),
                  width: 300,
                  height: 60,
//                  color: Colors.black,
                  child: Center(
                    child: Text("Change Main News",
                      style: TextStyle(color: Colors.white, fontSize: 25),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                    new AddArticle(),
                    ));

              }
              ,child: Center(
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.all(Radius.circular(55))
                  ),
                  width: 300,
                  height: 60,
//                  color: Colors.black,
                  child: Center(
                    child: Text("Add Article",
                      style: TextStyle(color: Colors.white, fontSize: 25),),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
