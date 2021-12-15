
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:politicalpen/db.dart';
import '../widgets.dart';
import 'package:intl/intl.dart' as intl;
//import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  DataBaseService dataBaseService = new DataBaseService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ArticleTitle = TextEditingController();
  TextEditingController ArticleDesc = TextEditingController();
  TextEditingController ArticleAR = TextEditingController();
  TextEditingController ArticleENG = TextEditingController();
  List<DropdownMenuItem<String>> ArticleCateg =
  <DropdownMenuItem<String>>[];
  String _currentCategory;
//  String _currentBrand;
  File _image;
  bool isLoading = false;

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
      appBar:MyAppBar("Add Article",false),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 2.5),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                  source: ImageSource.gallery,),
                                );
                          },
                          child: _displayChild()),
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'enter article title',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: ArticleTitle,
                  decoration: InputDecoration(hintText: 'Article Title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the Article Title';
                    } else if (value.length > 200) {
                      return 'Article Title cant have more than 200 letters';
                    }
                  },
                ),
              ),
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

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  maxLines: 4,
                  controller: ArticleDesc,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Article Descr',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the Article Desc';
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  maxLines: 10,
                  controller: ArticleENG,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(

                    hintText: 'Article In English',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the Article In English';
                    }
                  },
                ),

              ),
                Padding(
                padding: const EdgeInsets.all(12.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    maxLines: 10,
                    controller: ArticleAR,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(

                      hintText: 'Article In Arabic',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the Article In Arabic';
                      }
                    },
                  ),
                ),

              ),

              FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text('Add Article'),
                onPressed: () {
                  validateAndUpload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {

    setState(() {
      ArticleCateg = getCategoriesDropdown();
      _currentCategory = "local";
    });
  }


  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }


  void _selectImage(Future<File> pickImage,) async {
    File tempImg = await pickImage;
    setState(() => _image =tempImg);

  }

  Widget _displayChild() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Container(
        width: 250,
        height: 300,
        child: Image.file(
          _image,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image != null) {
          String imageUrl;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
          storage.ref().child(picture).putFile(_image);

          task1.onComplete.then((snapshot) async {
            imageUrl = await snapshot.ref.getDownloadURL();

            String image = imageUrl;
//            print(image);
            DateTime now = DateTime.now();
            String formattedDate = intl.DateFormat('yyyy/MM dd/MM/yyyy kk:mm').format(now);
//            String Date=new DateFormat.yMMMd().format(new DateTime.now());
//            print(formattedDate+" ===================");
            await dataBaseService.UploadArticle(
              _currentCategory,
              ArticleTitle.text,
                ArticleDesc.text,
                formattedDate,
                ArticleAR.text,
                ArticleENG.text,
                image,
            );
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });

      } else {
        setState(() => isLoading = false);
      }
    }
  }
}
