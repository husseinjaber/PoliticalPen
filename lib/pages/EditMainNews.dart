
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:politicalpen/db.dart';
import '../widgets.dart';

class EditMainNews extends StatefulWidget {
  @override
  _EditMainNewsState createState() => _EditMainNewsState();
}

class _EditMainNewsState extends State<EditMainNews> {
  DataBaseService dataBaseService = new DataBaseService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> ArticleCateg =
  <DropdownMenuItem<String>>[];
  String _currentCategory;

  @override
  void initState() {
    _getCategories();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();

    setState(() {
      items.add(
          DropdownMenuItem(
              child: Text("local"),
              value: "local"));
    });
    setState(() {
      items.add(

          DropdownMenuItem(
              child: Text("regional"),
              value: "regional"));
    });
    setState(() {
      items.add(

          DropdownMenuItem(
              child: Text("international"),
              value: "international"));
    });
    setState(() {
      items.add(
          DropdownMenuItem(
              child: Text("personal"),
              value: "personal"));
    });

    return items;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Edit Main News", false),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Category: ',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DropdownButton(
                  items: ArticleCateg,
                  onChanged: changeSelectedCategory,
                  value: _currentCategory,
                ),

                FlatButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Edit'),
                  onPressed: () {
                    SendCat();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getCategories() {
    setState(() {
      ArticleCateg = getCategoriesDropdown();
      _currentCategory = "local";
    });
  }


  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }


  void SendCat() {
    dataBaseService.EditMainNews(_currentCategory);
    Navigator.pop(context);
  }
}